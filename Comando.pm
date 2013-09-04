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
1;	
