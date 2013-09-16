#! /usr/bin/perl -w
package Programa;
use Comando;

#Construtor do objeto programa.
#Todo programa tem como atributos um vetor de comandos, um hash (label => linha programa),
#e um contador de linhas (posi).
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

#Recebe uma linha e retornar um Programa.
sub interpretaLinha
{
	#Pega argumentos 
	my $self = shift;
	my $linha = shift;

	#Retira comentarios do codigo
	$linha =~ s/#.*//;	

	# Verifica o formato da sintaxe
	if( $linha !~ /\s*([a-zA-Z0-9]+\:)?  \s*( (([a-zA-Z]+)\s+([a-zA-Z0-9]+)) |([a-zA-Z]+) )?/x)
	{
		print "Syntax error\n";
	}
	else
	{
		if($1)
		{
			my $rotulo = $1;
			chop ($rotulo); #tira os : do final.

			#Cria nova entrada no hash de labels caso o label ainda nao exista
			if(!$self->existeLabel($rotulo))
			{
				$self->novoLabel($rotulo);
			}
			else
			{
				print "Redefinição de label.";
				return 0;
			} 
		}
		if($3)
		{
			#Insere novo comando (codigo, argumento)
			my $cmd = novo Comando($4, $5);
			$self->insereComando($cmd);
		} 
		
		if($6)
		{
			#Insere novo comando (codigo, undef)
			my $cmd = novo Comando($6, undef);
			$self->insereComando($cmd); 
		}
	}
	return $self; #Recomendado.
}

#Insere um comando no vetor de comandos de uma instancia de Programa
sub insereComando
{
	$self = shift;
	$self->{posi}++;
	$vetor = $self->{vetor};
	push(@$vetor,shift);

	return $self;
}

#Verifica a existencia de uma chave no hash de labels
sub existeLabel
{
	(my $self,my $label) = (@_);

	my $labelsHash = $self->{label};

	return exists $labelsHash->{($label)};
}

#Cria uma nova chave no hash de labels e atribui o numero da linha respectiva
sub novoLabel
{
	(my $self,my $label) = (@_);
	my $labelsHash = $self->{label};

	$labelsHash->{$label} = $self->{posi};

	return $self;
}

#Retornar o tamanho do vetor de comandos
sub getTam
{
	my $self = shift;
	my $vetor =	$self->{vetor};
	return scalar @$vetor;
}

#Retorna o comando do indice "$ind" do vetor de comandos
sub getCmd
{
	(my $prog, my $ind) = (@_);
	return $prog->{vetor}->[$ind];

}

#Retornar a linha de ocorrencia de keyPossible, se essa existir
sub getLabel
{
	(my $self, my $keyPossible) = (@_);
	my $labelsHash = $self->{label};
	if(exists $labelsHash->{$keyPossible})
	{
		return $labelsHash->{$keyPossible};
	}
	return undef; 
}
1;
