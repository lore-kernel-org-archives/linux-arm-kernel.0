From: rogerq@ti.com (Roger Quadros)
Date: Wed, 26 Nov 2014 13:28:15 +0200
Subject: [PATCH 1/3] ARM: OMAP2+: Prepare to move GPMC to drivers by
 platform data header
In-Reply-To: <1416594856-15201-2-git-send-email-tony@atomide.com>
References: <1416594856-15201-1-git-send-email-tony@atomide.com>
 <1416594856-15201-2-git-send-email-tony@atomide.com>
Message-ID: <5475B94F.8010401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/11/14 20:34, Tony Lindgren wrote:
> We still need to support platform data for omap3 until it's booting
> in device tree only mode. So let's add platform_data/omap-gpmc.h for
> that, and a minimal linux/omap-gpmc.h for the save and restore used
> by the PM code.
> 
> Let's also keep a minimal mach-omap2/gpmc.h still around to avoid
> churn on the board-*.c files. Once omap3 boots in device tree only
> mode, we can drop mach-omap2/gpmc.h and we can make the data
> structures in platform_data/omap-gpmc.h private to the GPMC driver.
> 
> Note that we can now also remove gpmc-nand.h and gpmc-onenand.h.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger
