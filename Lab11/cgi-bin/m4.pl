#!/usr/bin/perl
use CGI "param";

@names = param;

foreach $e (@names) {
    $_ = param($e);
    eval("\$$e='$_'");
}

print "Content-type: text/html\n\n";

print "<html><head><style>
body { background-color: $bg; }
p { color: $color; }
</style></head><body>";

print "<h1>This is the first page, form 4</h1>";
print "<p>$text</p>";

print "</body></html>";