package TestApp;

use Dancer2;
use Dancer2::Plugin::BrowserDetect;

use Data::Dumper;

get '/' => sub {
    return Dumper(browser_detect());
};

1;
