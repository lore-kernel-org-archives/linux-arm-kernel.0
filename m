From: tony@atomide.com (Tony Lindgren)
Date: Fri, 4 Jun 2010 09:03:39 +0300
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <201006040353.35816.marek.vasut@gmail.com>
References: <20100603192459.GA9169@n2100.arm.linux.org.uk>
	<201006040337.10593.marek.vasut@gmail.com>
	<201006040350.36944.marek.vasut@gmail.com>
	<201006040353.35816.marek.vasut@gmail.com>
Message-ID: <20100604060338.GH6499@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marek Vasut <marek.vasut@gmail.com> [100604 04:54]:
> > 
> > OMAP: palmte_defconfig, palmtt_defconfig, palmz71_defconfig
> 
> Ok, making them into one is compile tested. I'd be for calling it a 
> "palmomap_defconfig". Or maybe is there a plan to put whole OMAP1 into a single 
> defconfig ?

Yeah, we should have just one omap1_defconfig. It should already
mostly work already for 15xx + 16xx. To build in 7xx, the entry-macro.S
needs to be done the same way as for mach-omap2.

Regards,

Tony
