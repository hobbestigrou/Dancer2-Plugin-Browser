use strict;
use warnings;

use Test::More import => ['!pass'];


use lib 't/lib';
use TestApp;

use Dancer2;
use Plack::Test;
use HTTP::Request::Common;

plan tests => 2;

setting appdir => setting('appdir') . '/t';

my $app = Plack::Test->create( TestApp->to_app );
my $res = $app->request( GET '/' );

ok ($res);
like $res->content, qr/HTTP::BrowserDetect/;
