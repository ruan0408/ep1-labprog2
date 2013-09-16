#! usr/bin/perl -w
package Maquina;

use strict;

#Construtor do objeto maquina.
#Toda maquina tem como atributos uma pilha de dados, um vetor memória e um programa.
sub novo
{
	my $class = shift;
	my $prog = shift;  
	my $self = 
	{	
		dados => [],
		mem => [],
		programa => $prog,
	};
	return bless $self, $class;
}

sub pushDados #poe $valor no topo da pilha de dados
{
	(my $maq, my $valor) = (@_);
	my $vetor = $maq->{dados};
	push @{$vetor}, $valor;
	return $maq;
}

sub popDados #tira e retorna o topo da pilha de dados
{
	(my $maq) = (@_);
	my $vetor = $maq->{dados};
	if(@$vetor < 0)
	{
		callErro("Pop de pilha vazia.");
		return undef;
	}
	my $temp = pop @{$vetor};
	return $temp;
}

sub lookDados #consulta o topo da pilha de dados
{
	(my $maq) = (@_);
	my $vetor = $maq->{dados};
	if(@$vetor < 0)
	{
		callErro("Tentativa de visualização em pilha vazia.");
		return undef;
	}
	my $tam = scalar @$vetor;
	return $$vetor[$tam-1];
}

#Seta a posição $i da memoria da maquina $maq com $dado
sub setMem 
{
	(my $maq, my $dado, my $i) = (@_);
	my $vetor = $maq->{mem};
	$vetor->[$i] = $dado;
	return $maq;
}

#Retorna o dado da posição $i da memoria da maquina $maq
sub getMem 
{
	(my $maq, my $i) = (@_);
	my $vetor = $maq->{mem};
	if(!defined $vetor->[$i])
	{
		callErro("Memória na posição $i vazia.");
		return undef;
	}
	$a = $vetor->[$i];
	return $a;

}

#Função Jump
#Retorna o novo indice caso o Label exista.
#Caso contrário, retorna undef
sub jump
{
	my ($maq, $label) = @_;
	my $prog = $maq->{programa};
	my $indice;

	if(!$prog->existeLabel($label))
	{
		callErro("Label $label inexistente. Falha em Jump.");
		return undef;
	}

	return $prog->getLabel($label);
}
#Executa o programa de $maq
sub executa
{
	my $maq = shift;
	my $prog = $maq->{programa};
	my $ind;
	my $i = 0;
	while ($i < $prog->getTam())#vai até o numero de comandos no vetor
	{	
		my $a = $prog->getTam();

		my $cmd = $prog->getCmd($i);#pega comando posiçao i
		$ind = $maq->executaCmd($cmd);#executa comando.Passa prog por causa dos labels.
		if($ind != -1){$i = $ind;}   #retorna posição do jump, continua normalmente se for -1
		else{ $i++;} 
	}

}

#Printa uma mensagem de erro que é passada por argumento
sub callErro
{
	my $msg = shift;
	print "Maquina: $msg\n";
}	


# Função que recebe um objeto do Programa e outro objeto Comando.
# Essa função executa o comando, aplicando as modificações necessárias
# nas pilhas.

sub executaCmd
{
	(my $maq,my $cmd) = (@_);
	my $code = uc($cmd->getCode());
	my $valor = $cmd->getValor;
	my ($a, $b, $novoIndice);
	my $prog = $maq->{programa};

	$novoIndice = -1;

	
	if($code eq 'PUSH') 
	{
		$maq->pushDados($valor);
	} 
	elsif($code eq 'POP') 
	{
		return vetor->getTam() unless(defined $maq->popDados());
	} 
	elsif($code eq 'DUP')
	{
		$a = $maq->lookDados();
		return vetor->getTam() unless(defined $a);
		$maq->pushDados($a);
	}
	elsif($code eq 'ADD')
	{
		$a = $maq->popDados();
		return prog->getTam() if (!defined $a);
		$b = $maq->popDados();
		return prog->getTam() if (!defined $b);
		$maq->pushDados($a + $b);
	}
	elsif($code eq 'SUB')
	{
		$a = $maq->popDados();
		return prog->getTam() if (!defined $a); #Erro no POP
		$b = $maq->popDados();
		return prog->getTam() if (!defined $b);
		$maq->pushDados($b - $a);
	}
	elsif($code eq 'MUL')
	{
		$a = $maq->popDados();
		return prog->getTam() if (!defined $a);
		$b = $maq->popDados();
		return prog->getTam() if (!defined $b);
		$maq->pushDados($a * $b);
	}
	elsif($code eq 'DIV')
	{
		$a = $maq->popDados();
		return prog->getTam() if (!defined $a);
		$b = $maq->popDados();
		return prog->getTam() if (!defined $b);
		$maq->pushDados($b/$a);
	}
	elsif($code eq 'JMP')
	{
		$novoIndice = $maq->jump($valor);
		return $prog->getTam() if(!defined $novoIndice);
	}
	elsif($code eq 'JIT')
	{
		$a = $maq->popDados();
		return $prog->getTam() unless(defined $a);

		if($a)
		{
			$novoIndice =$maq->jump($valor);
			return $prog->getTam() unless(defined $a);
		}
		
		
	}
	elsif($code eq 'JIF')
	{
		$a = $maq->popDados();
		return $prog->getTam() unless(defined $a);

		if(!$a)
		{
			$novoIndice =$maq->jump($valor);
			return $prog->getTam() unless(defined $a);
		}

	}
	elsif($code eq 'EQ')
	{
		$a = $maq->popDados();
		return prog->getTam() if (!defined $a);
		$b = $maq->popDados();
		return prog->getTam() if (!defined $b);
		$maq->pushDados($b == $a ? 1 : 0);
	}
	elsif($code eq 'GT')
	{
		$a = $maq->popDados();
		return prog->getTam() if (!defined $a);
		$b = $maq->popDados();
		return prog->getTam() if (!defined $b);
		$maq->pushDados($b > $a? 1 : 0);
	}
	elsif($code eq 'GE')
	{
		$a = $maq->popDados();
		return prog->getTam() if (!defined $a);
		$b = $maq->popDados();
		return prog->getTam() if (!defined $b);
		$maq->pushDados($b >= $a? 1 : 0);
	}
	elsif($code eq 'LT')
	{
		$a = $maq->popDados();
		return prog->getTam() if (!defined $a);
		$b = $maq->popDados();
		return prog->getTam() if (!defined $b);
		$maq->pushDados($b < $a? 1 : 0);
	}
	elsif($code eq 'LE')
	{
		$a = $maq->popDados();
		return prog->getTam() if (!defined $a);
		$b = $maq->popDados();
		return prog->getTam() if (!defined $b);
		$maq->pushDados($b <= $a? 1 : 0);
	}
	elsif($code eq 'NE')
	{
		$a = $maq->popDados();
		return prog->getTam() if (!defined $a);
		$b = $maq->popDados();
		return prog->getTam() if (!defined $b);
		$maq->pushDados($b != $a? 1 : 0);
	}
	elsif($code eq 'STO')
	{
		my $dado = $maq->popDados();
		return $prog->getTam() unless(defined $dado);
		$maq->setMem($dado, $valor);
	}
	elsif($code eq 'RCL')
	{
		my $dado = $maq->getMem($valor);
		return $prog->getTam() unless (defined $dado);
		$maq->pushDados($dado);
	}
	elsif($code eq 'END')
	{
		$novoIndice = $prog->getTam();
	}
	elsif($code eq 'PRN')
	{
		$a = $maq->popDados();
		return $prog->getTam() unless(defined $a);
		print "$a\n";
	}
	else 
	{
		callErro("Intrução do vetor de isntruções não reconhecida.");
		$novoIndice = $prog->getTam();
		# O programa encerra;
	}
	return $novoIndice;
}

1;
