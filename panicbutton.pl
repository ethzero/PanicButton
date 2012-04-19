#!/usr/bin/perl
use Device::USB::PanicButton;
use PHP::Functions::Mail qw(mail);
use Daemon::Generic;

newdaemon(
	progname        => 'panicbutton',
	pidfile         => '/var/run/dap.pid',
	configfile      => '/etc/panicbutton.conf',
);

sub gd_preconfig
{
	my ($self) = @_;
#	open(CONFIG, "<$self->{configfile}") or die;
#	while(<CONFIG>) {
#		$sleeptime = $1 if /^sleeptime\s+(\d+)/;
#	}
#	close(CONFIG);
	return ();
}


sub gd_run
{
	my $pbutton = Device::USB::PanicButton->new();
	
#	if(!$pbutton || $pbutton->error()) {
#		printf(STDERR "FATAL: ". $pbutton->error() ."\n");
#		exit(-1);
#	}

	while(1) {
		my $pbutton = Device::USB::PanicButton->new();
		my $result = $pbutton->pressed();
		
		if($result == 1) {
			printf("Panic button pressed! ;)\n");

#			system ('echo "Thank you for pressing the self destruct button" | text2wave | sndfile-play -');
#			system ('sndfile-play /usr/local/bin/ninaself.wav');
#			system ('sndfile-play /usr/local/bin/gingerscot.wav');
			system('/bin/umount /media/TheOracle');
	
		} elsif($result < 0) {
#			printf(STDERR "WARN: ". $pbutton->error() ."\n");
#			system ('/usr/local/bin/detectapanic.pl restart');
#			exit(1);
		}       
		
		sleep(1);
	}
}
