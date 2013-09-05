#! /usr/bin/perl -w
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
	my $code = $cmd->getCode;
	my $valor = $cmd->getValor;
	return 0;
}

1;
