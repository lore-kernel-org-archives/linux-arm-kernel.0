From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Jan 2013 20:16:13 +0000
Subject: [PATCH 02/15] ARM: mvebu: build coherency_ll.S for arch=armv7-a
In-Reply-To: <20130121190302.GN22517@atomide.com>
References: <1358788568-11137-1-git-send-email-arnd@arndb.de>
 <1358788568-11137-3-git-send-email-arnd@arndb.de>
 <20130121190302.GN22517@atomide.com>
Message-ID: <201301212016.13727.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 January 2013, Tony Lindgren wrote:
> > 
> > arch/arm/mach-mvebu/coherency_ll.S: Assembler messages:
> > arch/arm/mach-mvebu/coherency_ll.S:45: Error: selected processor does not support ARM mode `dsb'
> 
> This should be already fixed by 72533b (arm: mvebu: Fix compile for
> multiplatform when ARMv6 is selected) in arm-soc fixes branch.
> 

Ok, silly me, I forgot to check my own tree :)

Thanks for looking into it!

	Arnd
