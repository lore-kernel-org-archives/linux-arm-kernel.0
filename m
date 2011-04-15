From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Fri, 15 Apr 2011 16:52:38 +0300
Subject: [RFC PATCH] Consolidate SRAM support
In-Reply-To: <20110415130607.GM1611@n2100.arm.linux.org.uk>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
Message-ID: <20110415135237.GA9513@zarco>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russel,

Just small comment,

On Fri, Apr 15, 2011 at 08:06:07AM -0500, Russell King wrote:

> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index a3f50b3..3588749 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -75,7 +75,6 @@
>  static unsigned long omap_sram_start;
>  static unsigned long omap_sram_base;
>  static unsigned long omap_sram_size;
> -static unsigned long omap_sram_ceil;

I think you missed one occurrence of omap_sram_ceil at omap3_sram_restore_context.
Probably you have compile-tested w/o CONFIG_PM?

All best,

-- 
Eduardo Valentin
