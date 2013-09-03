#! /usr/bin/perl 


#open(CODMAQ, $ARGV[1]);

#while(<STDIN>)
#{
  
#}

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

#sub set

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

sub novoComando
{
  $self = shift;
  $self->{posi} = $self->posi+1;
  $vetor = $self->{vetor};
  push(@$vetor,shift);
}

#pog->novoComando(objComando);


#package Maquina

#sub novo
#{

#}
