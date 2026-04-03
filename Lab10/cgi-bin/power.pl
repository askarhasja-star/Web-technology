#!/usr/bin/perl
use strict;
use warnings;
use CGI qw(param);
use CGI::Carp qw(fatalsToBrowser);

my $a = param("a") // 0;
my $n = param("n") // 0;

my $b = $a ** $n;

print "Content-type: text/html\n\n";

print <<HTML;
<html>
<head><title>Result</title></head>
<body>
<h2>Result</h2>
<p>$a<sup>$n</sup> = $b</p>
<a href="/power.html">Back</a>
</body>
</html>
HTML