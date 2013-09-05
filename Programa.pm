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

sub interpretaLinha
{
  #Pega argumentos
  my $self = shift;
  my $linha = shift;

  print "Linha $self->{posi}: $linha  || \n";

  #$linha =~ s/\#.*//; #Elimina comentários



  if($linha !~ /([a-zA-Z]+[a-zA-Z0-9]*\:)?(([a-zA-Z]+)\s+([a-zA-Z0-9]+))|([a-zA-Z])/)
  #if(!/([a-zA-Z]+:)?(([a-zA-Z])+([0-9]+|[a-zA-Z]+)?)?/)
    {print "Syntax error\n"}
  else
  {


    if($1)
    {
      my $rotulo = $1;
      chop($rotulo);#tirando':'

      print "ACHEI ROTULO\n";
      

      if(!$self->existeLabel($rotulo))
      {
        $self->novoLabel($rotulo);
      }
      else
      {
        print "Redefinição de label.";
        return 0; #fail
      } 

      print "Label :";#. $rotulo ."\n";
    }

    if($2)
    {
      $cmd = novo Comando($3, $4);
    }

    if($3)
    {
      $cmd = novo Comando($5, undef);
    }
    $self->insereComando($cmd); 
    
  }

  return $self; #Recomendado.
}

sub insereComando
{
  $self = shift;
  $self->{posi} = $self->{posi}+1;
  $vetor = $self->{vetor};
  push(@$vetor,shift);

  return $self
}


sub existeLabel
{
  (my $self,my $label) = (@_);

  my $labelsHash = $self->{label};

  return 1 if($labelsHash->{$label} != undef );
  return 0;

}


sub novoLabel
{
  (my $self,my $label,my $nLinha) = (@_);
  my $labelsHash = $self->{label};

  print "frita\n";

  $labelsHash->{$label} = $nLinha;

  return $self;
}
#pog->novoComando(objComando);
1;
