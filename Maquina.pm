#! usrbinperl -w
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
	(my $self, my $prog, my $cmd) = (@_);
	my $code = uc($cmd->getCode);
	my $valor = $cmd->getValor;# permitiremos ROTULO e rotulo, serem labels diferentes?
	my $a, my $b;

	if($code eq 'PUSH') 
	{
		pushDados($valor);
	} 
	elsif($code eq 'POP') 
	{
		popDados();
	} 
	elsif($code eq 'DUP')
	{
		pushDados(lookDados());
	}
	elsif($code eq 'ADD')
	{
		$a = popDados();
		$b = popDados();
		pushDados($a + $b);
	}
	elsif($code eq 'SUB')
	{
		$a = popDados();
		$b = popDados();
		pushDados($b - $a);	#tipo calc. posfixa
	}
	elsif($code eq 'MUL')
	{
		$a = popDados();
		$b = popDados();
		pushDados($a * $b);
	}
	elsif($code eq 'DIV')
	{
		$a = popDados();
		$b = popDados();
		pushDados($b/$a);
	}
	elsif($code eq 'JMP')
	{

	}
	elsif($code eq 'JIT')
	{

	}
	elsif($code eq 'JIF')
	{

	}
	elsif($code eq 'EQ')
	{

	}
	elsif($code eq 'GT')
	{

	}
	elsif($code eq 'GE')
	{

	}
	elsif($code eq 'LT')
	{

	}
	elsif($code eq 'LE')
	{

	}
	elsif($code eq 'NE')
	{

	}
	elsif($code eq 'STO')
	{

	}
	elsif($code eq 'RCL')
	{

	}
	elsif($code eq 'END')
	{

	}
	elsif($code eq 'PRN')
	{

	}
	else 
	{
		print "Syntax error\n";
	}
}

1;
