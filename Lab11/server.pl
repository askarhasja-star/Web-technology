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

    #по умолчанию открываем форму
    $path = "form.html" if $path eq "";


    # CGI (m1.pl - m4.pl)

    if ($path =~ m{^cgi-bin/(m[1-4]\.pl)$}) {

        my $base = getcwd();
        my $script = "$base/$path";

        if (-e $script) {

            #передаём параметры из формы
            local %ENV = %ENV;
            $ENV{'REQUEST_METHOD'} = 'GET';
            $ENV{'QUERY_STRING'} = $cgi->query_string();

            print "HTTP/1.0 200 OK\r\n";

            eval {
                do $script;
            };

            print "<h3>Ошибка: $@</h3>" if $@;

        } else {
            print "HTTP/1.0 404 Not Found\r\n\r\nNo file";
        }

        return;
    }


    # HTML 

    if ($path eq "form.html" && -e $path) {

        open(my $fh, "<", $path);
        print "HTTP/1.0 200 OK\r\n\r\n";
        print while <$fh>;
        close($fh);

    } else {
        print "HTTP/1.0 404 Not Found\r\n\r\n";
    }
}