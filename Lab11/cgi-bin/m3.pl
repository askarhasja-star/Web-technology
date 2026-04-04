#!/usr/bin/perl
use CGI "param";

$text = param("text");
$bg = param("bg");
$color = param("color");

print "Content-type: text/html\n\n";

print "<html><head><style>
body { background-color: $bg; }
p { color: $color; }
</style></head><body>";

print "<h1>This is the first page, form 3</h1>";
print "<p>$text</p>";

print "</body></html>";