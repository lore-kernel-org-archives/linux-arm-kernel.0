From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 1 Feb 2010 15:10:57 +0100
Subject: [PATCH 01/06] ARM: SuperH Mobile ARM, sh7367 and G3EVM support
In-Reply-To: <20100128124038.8982.82995.sendpatchset@rxone.opensource.se>
References: <20100128124028.8982.16123.sendpatchset@rxone.opensource.se>
	<20100128124038.8982.82995.sendpatchset@rxone.opensource.se>
Message-ID: <20100201141057.GB1340@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> This patch contains the SuperH Mobile ARM base support together
> with sh7367 CPU and G3EVM board support. Only timer, serial
> console and NOR flash are supported at this point. Patches for
> the interrupt controller, pinmux support, clock framework and
> runtime pm will be submitted as feature patches on top of this.
...
>  arch/arm/mach-shmobile/Makefile.boot              |    9 
>  arch/arm/mach-shmobile/board-g3evm.c              |  127 +++++++++++

I guess I'm confused. I thought superh was architecture, like arm
is.....?

I superh actually manufacturer? And can we get shorter name than
mach-shmobile? mach-shm?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
