#!/usr/bin/perl
use strict;
use warnings;
use HTTP::Server::Simple::CGI;
use Cwd;

my $server = HTTP::Server::Simple::CGI->new(8080);
$server->run();

sub HTTP::Server::Simple::CGI::handle_request {
    my ($self, $cgi) = @_;

    my $path = $cgi->path_info();
    $path =~ s/^\/+//;

    #по умолчанию открываем index.html
    $path = "index.html" if $path eq "";


    # CGI (color.pl)

    if ($path eq "cgi-bin/color.pl") {

        my $base = getcwd();
        my $script = "$base/$path";

        if (-e $script) {

            local %ENV = %ENV;

            #поддержка POST и GET
            $ENV{'REQUEST_METHOD'} = $cgi->request_method();
            $ENV{'QUERY_STRING'}  = $cgi->query_string();

            print "HTTP/1.0 200 OK\r\n";

            eval {
                do $script;
            };

            print "<h3>Error: $@</h3>" if $@;

        } else {
            print "HTTP/1.0 404 Not Found\r\n\r\nFile color.pl not find";
        }

        return;
    }


    # HTML (index.html)

    if ($path eq "index.html" && -e $path) {

        open(my $fh, "<", $path);
        print "HTTP/1.0 200 OK\r\n\r\n";
        print while <$fh>;
        close($fh);

    } else {
        print "HTTP/1.0 404 Not Found\r\n\r\nPage not find";
    }
}