#! usr/bin/perl -w
package Maquina;

sub novo
{
	my $class = shift;
	my $self = 
	{	# a maquina tera como atributo as pilhas and shit
		dados => [],
		mem => [],
		#??????????
	};
	return bless $self, $class;
}

sub pushDados #tira o topo da pilha de dados
{
	(my $maq, my $valor) = (@_);
	my $vetor = $maq->{dados};
	push @{$vetor}, $valor;
	return $maq;#poderiamos verificar se deu tudo certo
}

sub popDados #tira o topo da pilha de dados
{
	(my $maq) = (@_);
	my $vetor = $maq->{dados};
	my $temp = pop @{$vetor};
	print "POPED: $temp\n";
	return $temp;
}

sub lookDados #consulta o topo da pilha de dados
{
	(my $maq) = (@_);
	my $vetor = $maq->{dados};
	my $tam = scalar @$vetor;
	return $$vetor[$tam-1];#################################################
}
sub printDados 
{
	my $maq = shift;
	my $vetor = $maq->{dados};
	my $tam = scalar @$vetor;
	for (my $i = 0; $i < tam; $i++) 
	{
		print "$$vetor[i]\n";
	}
}
sub setMem 
{
	(my $maq, my $dado, my $i) = (@_);
	my $vetor = $maq->{mem};
	$vetor->[$i] = $dado;
	return $maq;#recomendado?
}

sub getMem 
{
	(my $maq, my $i) = (@_);
	my $vetor = $maq->{mem};
	return $vetor->[$i];
}

sub executa
{
	my ($maq, $prog) = (@_);
	my $ind;
	#$maq->printDados();
	#exit(-1);
	for (my $i = 0; $i < $prog->getTam(); $i++)#vai até o numero de comandos no vetor
	{	
		my $a = $prog->getTam();
		#print "$a\n";
		my $cmd = $prog->getCmd($i);#pega comando posiçao i
		$ind = $maq->executaCmd($prog, $cmd);#executa comando.passa prog por causa dos labels.
		if($ind != -1){$i = $ind;}#retorna posição do jump, continua normalmente se for -1
	}
	print "GGWP GLHF CQD\n";#homenagem ao pc
}

sub executaCmd#funcao bolada que vai terminar o ep
{
	print"bla\n";
	my ($maq, $prog, $cmd) = (@_);
	my $code = uc($cmd->getCode());
	my $valor = $cmd->getValor;# permitiremos ROTULO e rotulo, serem labels diferentes?
	my ($a, $b, $novoIndice);
	
	if($code eq 'PUSH') 
	{
		#print "auheuaheuae\n";
		$maq->pushDados($valor);
		$novoIndice = -1;
	} 
	elsif($code eq 'POP') 
	{
		$maq->popDados();
		$novoIndice = -1;
	} 
	elsif($code eq 'DUP')
	{
		$maq->pushDados($maq->lookDados());
		$novoIndice = -1;
	}
	elsif($code eq 'ADD')
	{
		$a = $maq->popDados();
		$b = $maq->popDados();
		print "A ta cagado na soma\n" unless (defined $a);
		print "B ta cagado na soma\n" unless (defined $b);
		$maq->pushDados($a + $b);
		$novoIndice = -1;
	}
	elsif($code eq 'SUB')
	{
		$a = $maq->popDados();
		$b = $maq->popDados();
		$maq->pushDados($b - $a);	#tipo calc. posfixa
		$novoIndice = -1;
	}
	elsif($code eq 'MUL')
	{
		$a = $maq->popDados();
		$b = $maq->popDados();
		$maq->pushDados($a * $b);
		$novoIndice = -1;
	}
	elsif($code eq 'DIV')
	{
		$a = $maq->popDados();
		$b = $maq->popDados();
		$maq->pushDados($b/$a);
		$novoIndice = -1;
	}
	elsif($code eq 'JMP')
	{
		$novoIndice = $prog->getValorHash($valor);
	}
	elsif($code eq 'JIT')
	{
		if($maq->lookDados())
		{
			$novoIndice = $prog->getValorHash($valor);
		}
		else
		{
			$novoIndice = -1;
		}
		
	}
	elsif($code eq 'JIF')
	{
		if(!$maq->lookDados())
		{
			$novoIndice = $prog->getValorHash($valor);
		}
		else
		{
			$novoIndice = -1;
		}
	}
	elsif($code eq 'EQ')
	{
		$a = $maq->popDados();
		$b = $maq->popDados();
		$maq->pushDados($b == $a);
		$novoIndice = -1;
	}
	elsif($code eq 'GT')
	{
		$a = $maq->popDados();
		$b = $maq->popDados();
		$maq->pushDados($b > $a);
		$novoIndice = -1;
	}
	elsif($code eq 'GE')
	{
		$a = $maq->popDados();
		$b = $maq->popDados();
		$maq->pushDados($b >= $a);
		$novoIndice = -1;
	}
	elsif($code eq 'LT')
	{
		$a = $maq->popDados();
		$b = $maq->popDados();
		$maq->pushDados($b < $a);
		$novoIndice = -1;
	}
	elsif($code eq 'LE')
	{
		$a = $maq->popDados();
		$b = $maq->popDados();
		$maq->pushDados($b <= $a);
		$novoIndice = -1;
	}
	elsif($code eq 'NE')
	{
		$a = $maq->popDados();
		$b = $maq->popDados();
		$maq->pushDados($b != $a);
		$novoIndice = -1;
	}
	elsif($code eq 'STO')
	{
		my $dado = $maq->popDados();
		$maq->setMem($dado, $valor);
		$novoIndice = -1;
	}
	elsif($code eq 'RCL')
	{
		my $dado = $maq->getMem($valor);
		$maq->pushDados($dado);
		$novoIndice = -1;
	}
	elsif($code eq 'END')
	{
		$novoIndice = $prog->getTam()-1;
	}
	elsif($code eq 'PRN')
	{
		$a = $maq->popDados();
		print "PRINT: $a\n";
		$novoIndice = -1;
	}
	else 
	{
		print "Syntax error2\n";
		$novoIndice = $prog->getTam()-1;
		# O programa encerra;
	}

	$, = " - ";

	print "----------PILHA ATUAL----------\n";
	print @{$maq->{dados}};
	print "\n------------\n";
	return $novoIndice;
}

1;
