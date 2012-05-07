From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Mon, 07 May 2012 23:16:25 +0200
Subject: [PATCH 3.4-rc4] ARM: OMAP1: Amstrad Delta: Fix wrong IRQ base in
 FIQ handler
In-Reply-To: <20120504165948.GC5613@atomide.com>
References: <1335806769-23711-1-git-send-email-jkrzyszt@tis.icnet.pl>
 <20120504165948.GC5613@atomide.com>
Message-ID: <1470735.vzc89Ry7Ka@acer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dnia pi?tek, 4 maja 2012 09:59:49 Tony Lindgren pisze:
> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [120430 10:30]:
> > Commit 384ebe1c2849160d040df3e68634ec506f13d9ff, "gpio/omap: Add DT
> > support to GPIO driver", introduced dynamic IRQ numbering of OMAP 
GPIO
> > interrupts, breaking all IH_GPIO_BASE based IRQ number calculations.
> > This issue was corrected in the OMAP GPIO driver and the related 
header
> > file with commit 25db711df3258d125dc1209800317e5c0ef3c870, 
"gpio/omap:
> > Fix IRQ handling for SPARSE_IRQ".
> > 
> > However, the Amstrad Delta FIQ handler, which replaces the gpio-omap
> > driver in serving GPIO interrupts on this board, still uses that
> > outdated method. Fix it.
> 
> Thanks applying into fixes.

Hi Tony,
Thanks for taking this patch, but I ca't see it applied into your fixes 
branch (the last one sitting there is "Linux 3.4-rc4" by Linus). Am I 
missing something?

Regards,
Janusz
