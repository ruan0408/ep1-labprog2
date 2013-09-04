#! /usr/bin/perl -w

use Comando;
use Programa;
use Maquina;
package main;

$maq = novo Maquina;
$prog = novo Programa;
$i = 0;
while(<>)
{
	if(/([a-zA-Z]+:)?([a-zA-Z]([0-9]+|[a-zA-Z]+)?)?/){}
	@linha = split(/ :/);
	#prog->label{shift @linha} = $i++; #sintaxe provavelmente errada
	$$prog{label}{shift @linha} = $i++;
	$cmd = novo Comando(shift @linha, shift @linha);
	$prog->insereComando($cmd);
}

#maq->executa(prog);
