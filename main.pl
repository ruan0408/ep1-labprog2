#! /usr/bin/perl -w

use Comando;
use Programa;	
use Maquina;
package main;
			
#Programa principal.
#Cada linha é interpretada e vira um comando, ao termino do while, temos um programa ($prog),
#que será executado pela maquina ($maq);
$prog = novo Programa;

while(<>)
{
	$prog->interpretaLinha($_);
}

$maq = novo Maquina($prog);
$maq->executa();
