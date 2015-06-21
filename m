From: benoar@dolka.fr (Benjamin Cama)
Date: Sun, 21 Jun 2015 19:36:04 +0200
Subject: Linkstation Mini and __machine_arch_type problem, not booting
 since 3.8
In-Reply-To: <20150620143609.GE1116@lunn.ch>
References: <97db3502cd014faf1c710b1cc0fe8848@dolka.fr>
 <55827D64.1090307@free-electrons.com> <1434678624.4767.22.camel@dolka.fr>
 <5583E1D9.2010002@free-electrons.com>
 <20150619114152.GA2936@io.lakedaemon.net>
 <1434760119.5177.6.camel@dolka.fr> <20150620143609.GE1116@lunn.ch>
Message-ID: <1434908164.5657.15.camel@dolka.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le samedi 20 juin 2015 ? 16:36 +0200, Andrew Lunn a ?crit :
> > 
> > > SERIAL_OF_PLATFORM?
> > 
> > Oh, and that was it!
> 
> This used to catch us all out a lot. What configuration are you using?
> orion5x_defconfig? Very likely a patch adding it to that would be
> accepted.

None. Sorry, I am used to the x86 world where I almost never used
default configs (and it's been a long time, too). I admit I never fully
understood the logic behind the defconfigs, apart from it meaning some
kind of ?less important? dependency on some specific options. Shouldn't
the main UART be a ?hard? dependency on every board?!

--
benjamin
