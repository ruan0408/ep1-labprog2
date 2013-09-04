#! /usr/bin/perl -w
package Maquina;

sub novo
{
	my $class = shift;
	my $self = {};
	return bless $self, $class;
}

sub executa{}
1;
