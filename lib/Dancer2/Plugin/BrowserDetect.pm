package Dancer2::Plugin::BrowserDetect;

use strict;
use warnings;

use Dancer2::Plugin;

use HTTP::BrowserDetect;

#ABSTRACT: Provides an easy to have info of the browser.

=method browser_detect

    browser_detect()
or
    <% browser_detect %>

To have info of the browser

    input: none
    output: A HTTP::BrowserDetect object

=cut

on_plugin_import {
    my $dsl = shift;
    $dsl->app->add_hook(
        Dancer2::Core::Hook->new(
            name => 'before_template',
            code => sub {
                my $tokens = shift;
                $tokens->{browser_detect} = _browser_detect($dsl);
            },
        )
    );
};

register browser_detect => sub {
    my $dsl = shift;
    _browser_detect($dsl);
};

sub _browser_detect {
    my $dsl = shift;
    my $useragent = $dsl->app->request->env->{HTTP_USER_AGENT};
    my $browser   = HTTP::BrowserDetect->new($useragent);

    return $browser;
}

register_plugin;

=encoding utf8

=head1 SYNOPSIS

    use Dancer2;
    use Dancer2::Plugin::BrowserDetect;

    get '/' => sub {
        my $browser = browser_detect();

        if ( $browser->windows && $browser->ie && $browser->major() < 6 ) {
            return "You have big failed, change your os, browser, and come back late.";
        }
    };

    dance;


=head1 DESCRIPTION

Provides an easy to have info of the browser.
keyword within your L<Dancer> application.

=head1 CONTRIBUTING

This module is developed on Github at:

L<https://github.com/hobbestigrou/Dancer2-Plugin-Browser>

Feel free to fork the repo and submit pull requests

=head1 BUGS

Please report any bugs or feature requests in github.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Dancer2::Plugin::BrowserDetect

=head1 SEE ALSO

L<Dancer>
L<HTTP::BrowserDetect>
L<Catalyst::TraitFor::Request::BrowserDetect>
L<Mojolicious::Plugin::BrowserDetect>
L<Dancer::Plugin::Browser>

=cut

1;
