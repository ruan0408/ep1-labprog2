#! /usr/bin/perl -w
package Comando;

sub novo
{
  my $class = shift;
  my $self = {
    opcode => shift,
    valor => shift,
  };
  bless $self, $class;
  return $self;
}

sub getCode
{
	my $self = shift;
	return $$self{opcode};
}

sub getValor
{
	my $self = shift;
	return $$self{valor};
}
1;	
