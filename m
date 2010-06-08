From: shanevolpe@gmail.com (Shane Volpe)
Date: Tue, 8 Jun 2010 10:38:36 -0400
Subject: Kernel 2.6.33: PXA270 Audio does not resume after resume from suspend
	state
Message-ID: <AANLkTiloYpM6LBNFHOfHGdvoHZ03cavW8vdmVZjHxSKC@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have upgraded an embedded system (PXA270) to the 2.6.33 kernel (from
2.6.23).  Now when I run an audio program (ogg123) and put the system
into standby then wake the system up the audio does not work (continue
playing) after resume until I terminate ogg123 and start again.  After
restarting ogg123 the audio works fine with out reseting the system or
changing anything else on the system.

The system is using the UCB1400 AC97 codec and just as added
information when the audio is locked up, after resume, the touchscreen
on the system still works which is also controlled by the UCB1400
audio codec.  I have also tried several other audio players and the
results are the same.   Has anyone else seen this bug and does anyone
have suggestions on further tests to perform to narrow down were the
bug may reside?
Regards,
Shane
