From: afzal@ti.com (Mohammed, Afzal)
Date: Mon, 3 Sep 2012 10:14:54 +0000
Subject: [PATCH 6/9] ARM: OMAP: Move gpio.h to include/linux/platform_data
In-Reply-To: <20120831005234.28732.10624.stgit@muffinssi.local>
References: <20120831004828.28732.902.stgit@muffinssi.local>
 <20120831005234.28732.10624.stgit@muffinssi.local>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9DC3AF@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 31, 2012 at 06:22:34, Tony Lindgren wrote:
> This way we can remove includes of plat/gpio.h which won't work
> with the single zImage support.
> 
> Note that we also remove the cpu_class_is_omap2() check
> in gpio-omap.c as the drivers should not call it as we need to
> make it local to arch/arm/mach-omap2 for single zImage support.
> 
> While at it, arrange the related includes in the standard way.
> 
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-mtd at lists.infradead.org
> Cc: alsa-devel at alsa-project.org
> Acked-by: Tony Lindgren <tony@atomide.com>

I think there is only one Tony ;)

Regards
Afzal
