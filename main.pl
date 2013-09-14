#! /usr/bin/perl -w

use Comando;
use Programa;	
use Maquina;
package main;
			

$prog = novo Programa;

while(<>)
{

	$prog->interpretaLinha($_);


	#@linha = split(/ :/);
	#prog->label{shift @linha} = $i++; #sintaxe provavelmente errada
	#$$prog{label}{shift @linha} = $i++;
}
#$hashRef = $prog->{label};

$maq = novo Maquina($prog);

#foreach $key (keys %$hashRef) #Printa label => nº do comando.
#{
#	print "Label: $key => $hashRef->{$key}\n ";
#}
$maq->executa();
#if () {
	# body...
#} else {
	# else...
#}