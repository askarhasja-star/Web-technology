#!/usr/bin/perl
use strict;
use warnings;
use CGI qw(param);
use CGI::Carp qw(fatalsToBrowser);

my $name = param("name") // "Guest";
my $age  = param("age")  // 0;

print "Content-type: text/html\n\n";

print "<html><body>";

if ($age <= 30) {
    print "Hi, $name!";
}
elsif ($age > 30 && $age < 50) {
    print "Hi, $name. You are at a wonderful age.";
}
else {
    print "Hi, $name. You are an elder.";
}

print "</body></html>";