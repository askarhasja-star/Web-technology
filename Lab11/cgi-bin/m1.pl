#!/usr/bin/perl
use CGI "param";

$q = new CGI;

$text = $q->param("text");
$bg = $q->param("bg");
$color = $q->param("color");

print "Content-type: text/html\n\n";

print "<html><head><style>
body { background-color: $bg; }
p { color: $color; }
</style></head><body>";

print "<h1>This is the first page, form 1</h1>";
print "<p>$text</p>";

print "</body></html>";