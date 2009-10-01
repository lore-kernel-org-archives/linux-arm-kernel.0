From: rene.wolf@mbda-systems.de (Wolf, Rene, HRO-GP)
Date: Thu, 1 Oct 2009 12:42:02 +0200
Subject: SPI, DMA and an i.MX31
In-Reply-To: <4ABC7094.9000701@warmcat.com>
References: <4AB8F9AE.1070006@billgatliff.com>	<59b21cf20909221245i355ccea0r44737e9112fd17c0@mail.gmail.com>
	<87077C4F48609F4392621D9F99DDE20901202E06@tesla.star.galaxy.io>
	<4ABC7094.9000701@warmcat.com>
Message-ID: <87077C4F48609F4392621D9F99DDE20901202E0A@tesla.star.galaxy.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello @ all.

For the rest of the previous week I was trying to get the SDMA to work
with CSPI3. I did not succeed in that. But also could not verify if
I did it wrong or if the SDMA api is failing. What works, is to register
a channel with the SDMA. This shows up in '/proc/sdma/channels', freeing
that channel also works. A new irq pops up in '/proc/interrupts'.
And I managed to get the software callback to work, at least once.
Because I don't know how to use the api of the SDMA I cannot say if I
did the correct setup sequence. Also there seam to be more than one way
of doing that. 

I made a git patch based on 2.6.31. It is around 2 megs. and bz2 of it
is still some 200 kb. I guess I should upload it somewhere. Plus I hope
to get a small demo code ready, to show what I tried.

@Andy:
May be you might try that with your mmc app. some time :-)

At the moment I'm waiting for green light on posting that patch, which
hopefully will arrive soon.


Cheers
Rene  


Rene Wolf
LFK-Lenkflugk?rpersysteme GmbH
Human Resources Operations & Policy, HRO
Landshuter Stra?e 26, 85716 Unterschlei?heim, GERMANY
Phone: +49 89 3179 8337
Fax: +49 8252 99 8964
E-Mail: rene.wolf at mbda-systems.de

http://www.mbda.net

Chairman of the Supervisory Board: Antoine Bouvier
Managing Director: Werner Kaltenegger
Registered Office: Schrobenhausen
Commercial Register: Amtsgericht Ingolstadt, HRB 4365
