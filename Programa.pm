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
#peniss
sub interpretaLinha
{
  #Pega argumentos 
  my $self = shift;
  my $linha = shift;

  print "Linha $self->{posi}: $linha  ||";

  #$linha =~ s/\#.*//; #Elimina comentários


  if($linha !~ /([a-zA-Z]+[a-zA-Z0-9]*\:)?\s*(([a-zA-Z]+)\s+([a-zA-Z0-9]+))|([a-zA-Z])/)
  #if(!/([a-zA-Z]+:)?(([a-zA-Z])+([0-9]+|[a-zA-Z]+)?)?/)
    {
      print "Syntax error\n"
    }
  else
  {
    
    if($1)
    {
      
      
      my $rotulo = $1;

     # $rotulo =~ s/[\:\s]*//;

     chop ($rotulo);


      print "|1 => $rotulo|\n";

      print "ACHEI LABEL\n";
      
      if(!$self->existeLabel($rotulo))
      {
        $self->novoLabel($rotulo);
      }
      else
      {
        print "Redefinição de label.";
        return 0; #fail
      } 

      print "Label :$rotulo &\n";
    }

    if($2)
    {
      print "2 => $2\n";
      $cmd = novo Comando($3, $4);
    }

    if($3)
    {
      print "3 => $3\n";
      $cmd = novo Comando($5, undef);
    }
    $self->insereComando($cmd); 
  }

  return $self; #Recomendado.
}

sub insereComando
{
  $self = shift;
  $self->{posi}++;
  #$self->{posi} = $self->{posi}+1;
  $vetor = $self->{vetor};
  push(@$vetor,shift);

  return $self;
}

sub existeLabel
{
  (my $self,my $label) = (@_);

  my $labelsHash = $self->{label};

  return exists $labelsHash->{($label)};
}

sub novoLabel
{
  (my $self,my $label,my $nLinha) = (@_);
  my $labelsHash = $self->{label};

  print "frita\n";

  $labelsHash->{$label} = $nLinha;

  return $self;
}

sub getPosi
{
  my $self = shift;
  return $$self{posi};
}

sub getCmd
{
  (my $self, my $ind) = (@_);
  return $$self{vetor}[$ind];
}

sub getValorHash
{
  (my $self, my $keyPossible) = (@_);
  return $self->{label}{$keyPossible}; #kim Possible
  #tenho duvidas se caso nao existir,
  #ele retorna undef, ou nao retorna nada e cria com valor undef
}
#pog->novoComando(objComando);
1;
