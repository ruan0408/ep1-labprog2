#! /usr/bin/perl -w
package Programa;
use Comando;
sub novo
{
	my $class = shift;
	my $self =
	{
		label => {},
		vetor =>  [],
		#posi => 0,
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

	#print "Linha $self->{posi}: $linha  ||";

	#$linha =~ s/\#.*//; #Elimina comentários
	#print "$linha\n";
	if($linha !~ /([a-zA-Z]+[a-zA-Z0-9]*\:)?\s*(([a-zA-Z]+)\s+([a-zA-Z0-9]+))|([a-zA-Z]+)/)
	{
		print "Syntax error\n";
	}
	# else
	# {
	#   if($2)
	#   {
	#     print "$1 || $3 || $4\n";  
	#   }
	#   if($5)
	#   {
	#     print "$1 || $5\n";
	#   }
	# }
	
	else
	{
		if($1)
		{
			my $rotulo = $1;

		 	chop ($rotulo);

		 	if(!$self->existeLabel($rotulo))
		 	{
		 		$self->novoLabel($rotulo);
		 	}
		 else
		 {
		 		print "Redefinição de label.";
				return 0; #fail
			} 
		}
		if($2)
		{
			#print "2 => $2\n";
			print "$3 || $4\n";
			$cmd = novo Comando($3, $4);
			#my $a = $cmd->getCode();
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
	#$self->{posi}++;
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

	$labelsHash->{$label} = $nLinha;

	return $self;
}

sub getTam
{
	my $self = shift;
	return scalar $self->{vetor};
}

sub getCmd
{
	(my $prog, my $ind) = (@_);
	return $prog->{vetor}->[$ind];

}

sub getValorHash
{
	(my $self, my $keyPossible) = (@_);
	my $labelsHash = $self->{label};
	if(exists $labelsHash->{$keyPossible})#kim Possible
	{
		return $labelsHash->{$keyPossible};
	}
	return undef; 
}
1;
