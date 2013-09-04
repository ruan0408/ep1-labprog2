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
	if(!/([a-zA-Z]+:)?(([a-zA-Z]+)\s+([a-zA-Z0-9]+))|([a-zA-Z])/)
	#if(!/([a-zA-Z]+:)?(([a-zA-Z])+([0-9]+|[a-zA-Z]+)?)?/)
		{print "Syntax error\n"}
	else
	{
		if($1)
		{
			$rotulo = $1;
			chop($rotulo);#tirando':'
			$$prog{label}{$rotulo} = $i++;
		}
		if($2)
		{
			print "$rotulo $3 $4\n";
			$cmd = novo Comando($3, $4);
		}	
		if($3)
		{
			$cmd = novo Comando($5, undef);
		}
		$prog->insereComando($cmd);	
		
	}
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