From: tony@atomide.com (Tony Lindgren)
Date: Thu, 6 Sep 2012 13:36:54 -0700
Subject: [PATCH 6/9] ARM: OMAP: Move gpio.h to include/linux/platform_data
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9DC3AF@DBDE01.ent.ti.com>
References: <20120831004828.28732.902.stgit@muffinssi.local>
 <20120831005234.28732.10624.stgit@muffinssi.local>
 <C8443D0743D26F4388EA172BF4E2A7A93E9DC3AF@DBDE01.ent.ti.com>
Message-ID: <20120906203653.GI1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mohammed, Afzal <afzal@ti.com> [120903 03:15]:
> Hi,
> 
> On Fri, Aug 31, 2012 at 06:22:34, Tony Lindgren wrote:
> > This way we can remove includes of plat/gpio.h which won't work
> > with the single zImage support.
> > 
> > Note that we also remove the cpu_class_is_omap2() check
> > in gpio-omap.c as the drivers should not call it as we need to
> > make it local to arch/arm/mach-omap2 for single zImage support.
> > 
> > While at it, arrange the related includes in the standard way.
> > 
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: linux-mtd at lists.infradead.org
> > Cc: alsa-devel at alsa-project.org
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> I think there is only one Tony ;)

Heh thanks I'll tell myself to replace it with Signed-off-by :)

Tony
