From: s-ghorai@ti.com (Ghorai, Sukumar)
Date: Wed, 4 Aug 2010 09:28:57 +0530
Subject: [PATCH v4 0/4] nand prefetch-irq support and ecc layout chanage
In-Reply-To: <1280764192-15053-1-git-send-email-s-ghorai@ti.com>
References: <1280764192-15053-1-git-send-email-s-ghorai@ti.com>
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030E5E4374@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Ghorai, Sukumar
> Sent: Monday, August 02, 2010 9:20 PM
> To: linux-omap at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org; linux-mtd at lists.infradead.org;
> Ghorai, Sukumar
> Subject: [PATCH v4 0/4] nand prefetch-irq support and ecc layout chanage
> 
>    The following set of patches applies on top of omap-for-linus.
> 
>    v4: Comments incorporated
> 
>    v3: http://www.mail-archive.com/linux-
> omap at vger.kernel.org/msg32071.html
>    	Rebase on latest codebase and previous patch(posted).
> 	http://www.mail-archive.com/linux-omap at vger.kernel.org/msg31963.html
> 
>    v2: Rebase on latest codebase and previous patch(posted).
> 	http://www.mail-archive.com/linux-omap at vger.kernel.org/msg31471.html
> 
>    v1: http://www.mail-archive.com/linux-
> omap at vger.kernel.org/msg26666.html
> 
> Sukumar Ghorai (4):
> 	omap3: nand: prefetch in irq mode support
> 	omap: nand: configurable fifo threshold to gain the throughput
> 	omap: nand: ecc layout select from board file
> 	omap: nand: making ecc layout as compatible with romcode ecc
> 
>  arch/arm/mach-omap2/board-flash.c      |    5 +-
>  arch/arm/mach-omap2/gpmc.c             |   15 ++-
>  arch/arm/plat-omap/include/plat/gpmc.h |    9 +-
>  arch/arm/plat-omap/include/plat/irqs.h |    1 +
>  arch/arm/plat-omap/include/plat/nand.h |    7 +
>  drivers/mtd/nand/Kconfig               |   14 ++-
>  drivers/mtd/nand/omap2.c               |  277
> ++++++++++++++++++++++++++++---
>  7 files changed, 294 insertions(+), 34 deletions(-)
[Ghorai] 
Tony,
Would you please check if you have any input further?

Regards,
Ghorai
