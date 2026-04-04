#!/usr/bin/perl
use strict;
use warnings;
use CGI qw(:standard);

print header();
print start_html("Результат");

# Получаем данные формы
my $code = param('color_code');
my $name = param('color_name');

# Хеш соответствия названия и цвета
my %colors = (
    red    => "Red",
    green  => "Green",
    blue   => "Blue",
    yellow => "Yellow",
    black  => "Black"
);

print "<h2>Результат</h2>";

# Вывод цвета по коду
print "<p style='color:$code;'>Text by code: $code</p>";

# Вывод цвета по названию
print "<p style='color:$name;'>Text by title: $colors{$name}</p>";

print end_html();