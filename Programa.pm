#! /usr/bin/perl -w
package Programa;

sub novo
{
  my $class = shift;
  my $self =
  {
    label => {},
    vetor =>  [],
    posi => 0,
  };
  bless $self, $class;
  return $self;
}

sub insereComando
{
  $self = shift;
  $self->{posi} = $self->posi+1;
  $vetor = $self->{vetor};
  push(@$vetor,shift);
}
#pog->novoComando(objComando);
1;
