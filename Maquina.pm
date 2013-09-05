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
	push($$maq->{dados}, $valor);
	return 1;#poderiamos verificar se deu tudo certo
}

sub popDados #tira o topo da pilha de dados
{
	(my $maq) = (@_);
	return pop($$maq->{dados});
}

sub lookDados #consulta o topo da pilha de dados
{
	(my $maq) = (@_);
	my $tam = scalar $$maq->{dados};
	return $$maq->{dados}[$tam-1];
}

sub setMem 
{
	(my $maq, my $dado, my $i) = (@_);
	$maq->{mem}[$i] = $dado;
	return $maq;#recomendado?
}

sub getMem 
{
	(my $maq, my $i) = (@_);
	return $maq->{mem}[$i];
}

sub executa
{
	(my $maq, my $prog) = (@_);
	my $ind;
	for (my $i = 0; $i < $prog->getPosi; $i++)#vai até o numero de comandos no vetor 
	{
		$cmd = $prog->getCmd($i);#pega comando posiçao i
		$ind = $maq->executaCmd($prog, $cmd);#executa comando.passa prog por causa dos labels.
		if($ind != undef){$i = $ind};#retorna posição do jump, continua normalmente se for undef
	}
	print "GGWP GLHF CQD\n";#homenagem ao pc
}

sub executaCmd#funcao bolada que vai terminar o ep
{
	(my $maq, my $prog, my $cmd) = (@_);
	my $code = uc($cmd->getCode);
	my $valor = $cmd->getValor;# permitiremos ROTULO e rotulo, serem labels diferentes?
	my $a, my $b;
	my $novoIndice;

	if($code eq 'PUSH') 
	{
		$maq->pushDados($valor);
		$novoIndice = undef;
	} 
	elsif($code eq 'POP') 
	{
		$maq->popDados();
		$novoIndice = undef;
	} 
	elsif($code eq 'DUP')
	{
		$maq->pushDados($maq->lookDados());
		$novoIndice = undef;
	}
	elsif($code eq 'ADD')
	{
		$a = popDados();
		$b = popDados();
		$maq->pushDados($a + $b);
		$novoIndice = undef;
	}
	elsif($code eq 'SUB')
	{
		$a = popDados();
		$b = popDados();
		$maq->pushDados($b - $a);	#tipo calc. posfixa
		$novoIndice = undef;
	}
	elsif($code eq 'MUL')
	{
		$a = popDados();
		$b = popDados();
		$maq->pushDados($a * $b);
		$novoIndice = undef;
	}
	elsif($code eq 'DIV')
	{
		$a = popDados();
		$b = popDados();
		$maq->pushDados($b/$a);
		$novoIndice = undef;
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
			$novoIndice = undef;
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
			$novoIndice = undef;
		}
	}
	elsif($code eq 'EQ')
	{
		$a = popDados();
		$b = popDados();
		$maq->pushDados($b == $a);
		$novoIndice = undef;
	}
	elsif($code eq 'GT')
	{
		$a = popDados();
		$b = popDados();
		$maq->pushDados($b > $a);
		$novoIndice = undef;
	}
	elsif($code eq 'GE')
	{
		$a = popDados();
		$b = popDados();
		$maq->pushDados($b >= $a);
		$novoIndice = undef;
	}
	elsif($code eq 'LT')
	{
		$a = popDados();
		$b = popDados();
		$maq->pushDados($b < $a);
		$novoIndice = undef;
	}
	elsif($code eq 'LE')
	{
		$a = popDados();
		$b = popDados();
		$maq->pushDados($b <= $a);
		$novoIndice = undef;
	}
	elsif($code eq 'NE')
	{
		$a = popDados();
		$b = popDados();
		$maq->pushDados($b != $a);
		$novoIndice = undef;
	}
	elsif($code eq 'STO')
	{
		my $dado = popDados();
		$maq->setMem($dado, $valor);
		$novoIndice = undef;
	}
	elsif($code eq 'RCL')
	{
		my $dado = $maq->getMem($valor);
		$maq->pushDados($dado);
		$novoIndice = undef;
	}
	elsif($code eq 'END')
	{
		$novoIndice = $prog->getPosi()-1;
	}
	elsif($code eq 'PRN')
	{
		print "popDados()\n";
	}
	else 
	{
		print "Syntax error\n";
		$novoIndice = $prog->getPosi()-1;
		# O programa encerra;
	}
	return $novoIndice;
}

1;
