#!/usr/bin/env perl

# LaTeX
$latex = 'uplatex -interaction=nonstopmode -file-line-error %O %S';
$max_repeat = 5;

# # BibTeX
$bibtex = 'upbibtex %O %S';
$biber = 'biber --bblencoding=utf8 -u -U --output_safechars %O %S';

# DVI / PDF
# dvi -> pdf の変換に使用するものとしてdvipdfmxを指定
$dvipdf = 'dvipdfmx %O -o %D %S'; # dvipdfmx [options] -o output.pdf input.dvi ということになる
$pdf_mode = 3; # dviファイルからpdfを作成する場合 uplatexならこれ

# output directory 
# srcと同じディレクトリにあるoutディレクトリに出力する
use Cwd;
my $current_dir_path = Cwd::getcwd();
print "current directory path: $current_dir_path\n";
my $source_path = $ARGV[$#ARGV]; # latexmkコマンドに渡された最後の引数(= ソースファイルの絶対/相対パス）を取得
# e.g. latemk src/section1/section1.tex なら $relative_path = 'src/section1/section1.tex'
my $full_path = ($source_path =~ m!^/!)? $source_path: "$current_dir_path/$source_path"; #絶対パスに変換
print "source file path: $full_path\n";
if ($full_path =~ m!(.*\/test)\/.*$!) {
    $full_path = $1;
}else{
    die("The source file path does not match the pattern");
}
print "project dirctory path: $full_path\n";

$out_dir = "$full_path/out"; # e.g. /Users/username/project1/out
print "output directory path: $out_dir\n";

