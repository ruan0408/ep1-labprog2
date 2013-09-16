#! /usr/bin/perl -w
package Comando;

#Construtor do objeto comando.
#Todo comando de um codigo (opcode) e um valor(argumento).
sub novo
{
  my $class = shift;
  my $self = 
  {
    opcode => shift,
    valor => shift,
  };
  bless $self, $class;
  return $self;
}

#Recebe um objeto comando e retorna o codigo desse objeto.
sub getCode
{
	my $self = shift;
  #print "$$self{opcode}\n";
	return $self->{opcode};
}

#Recebe um objeto comando e retorna o valor desse objeto.
sub getValor
{
	my $self = shift;
	return $self->{valor};
}
1;	
