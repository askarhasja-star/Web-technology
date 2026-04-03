#!/usr/bin/perl
use strict;
use warnings;
use HTTP::Server::Simple::CGI;
use CGI qw(:standard);
use Cwd;   # для getcwd()

# Сервер на порту 8080
my $server = HTTP::Server::Simple::CGI->new(8080);
$server->run();

# Обработка запросов
sub HTTP::Server::Simple::CGI::handle_request {
    my ($self, $cgi) = @_;

    my $path = $cgi->path_info();
    $path =~ s/^\/+//;  # убираем слеши спереди

    # Если пусто, можно отдавать index.html
    $path = "index.html" if $path eq "";

    # --- Обработка CGI ---
    if ($path =~ m{^cgi-bin/(.+\.pl)$}) {
        my $script_name = $1;

        # Абсолютный путь к скрипту
        my $base = getcwd();
        my $script = "$base/cgi-bin/$script_name";

        if (-e $script) {
            print "HTTP/1.0 200 OK\r\n\r\n";

            # eval ловит ошибки скрипта
            eval {
                local @ARGV = ();       # очищаем аргументы
                do $script or die "Cannot execute $script: $!";
            };
            print "<pre>CGI Error: $@</pre>" if $@;
        } else {
            print "<pre>DEBUG: $script NOT FOUND!</pre>";
            print "HTTP/1.0 404 Not Found\r\n\r\nNot Found";
        }
        return;
    }

    # --- Отдаём обычные HTML ---
    if (-e $path) {
        open(my $fh, "<", $path) or do {
            print "HTTP/1.0 500 Internal Server Error\r\n\r\nCannot open $path";
            return;
        };
        print "HTTP/1.0 200 OK\r\n\r\n";
        print while <$fh>;
        close($fh);
    } else {
        print "HTTP/1.0 404 Not Found\r\n\r\nNot Found";
    }
}