From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 4 Aug 2012 23:01:59 +0200
Subject: [PATCH] [RFC] arm: add documentation describing Marvell
 families of SoC
In-Reply-To: <alpine.LFD.2.02.1207171452250.9293@xanadu.home>
References: <1342535201-12907-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201207171509.30509.arnd@arndb.de>
 <alpine.LFD.2.02.1207171115161.9293@xanadu.home>
 <alpine.LFD.2.02.1207171452250.9293@xanadu.home>
Message-ID: <20120804230159.12f7108a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Nicolas,

Le Tue, 17 Jul 2012 14:58:12 -0400 (EDT),
Nicolas Pitre <nico@fluxnic.net> a ?crit :

> > I think I have an old list that was compiled by Lennert.  I'll try to 
> > dig it out in case this document could benefit from it.
> 
> Here's what I've dug out. This is dated October 2007.
> 
> ----- >8
> 
> family			out of order			in order
> ==============================================================================
> no mmu		|				|			     |
> no cache	|	Falcon			|	Falcon D	     |
> "966"		|				|	a.k.a. Dragonite     |
> ==============================================================================
> no mmu		|				|			     |
> cache		|	Osprey			|	Osprey D	     |
> "946"		|				|			     |
> ==============================================================================
> 		|	single issue: Mohawk	|			     |
> mmu		|	a.k.a. Feroceon 1850	|			     |
> cache		|	a.k.a. Feroceon FR-331	|	single issue:	     |
> "926"		|				|	Mohawk D	     |
> 		|	dual issue: Jolteon	|			     |
> 		|	a.k.a. Feroceon 2850	|			     |
> ==============================================================================
> 
> Variants:
> - Falcon DMC - Multi-Core version of the Falcon D
> - Falcon DMT - Multi-Thread version of the Falcon D
> - Osprey DMT - Multi-Thread version of Osprey D
> 
> There is also the Flareon, which is what will be used in Dove:
> - Based on the Jolteon
> - v6/v7 support
> - packaged with L2, VFP, AXI
> 
> All of these cores can be mixed-and-matched with L2, VFP, AXI, wMMXt,
> etc.

Thanks for those details. However, I'm not really able to match those
details against the Marvell SoCs themselves. Could you detail which ARM
core corresponds to which Marvell SoC family, or specific model?

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
