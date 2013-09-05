#! /usr/bin/perl -w

use Comando;
use Programa;	
use Maquina;
package main;

$maq = novo Maquina;
$prog = novo Programa;

while(<>)
{

	$prog->interpretaLinha($_);


	#@linha = split(/ :/);
	#prog->label{shift @linha} = $i++; #sintaxe provavelmente errada
	#$$prog{label}{shift @linha} = $i++;
}
$maq->executa($prog);
#if () {
	# body...
#} else {
	# else...
#}