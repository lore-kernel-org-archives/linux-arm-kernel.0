From: tony@atomide.com (Tony Lindgren)
Date: Mon, 1 Oct 2012 20:21:06 -0700
Subject: [PATCH V2 0/7] ARM: OMAP: Move plat/dma*.h,omap-secure.h
 headers as part of single zImage work
In-Reply-To: <1349117226-4980-1-git-send-email-lokeshvutla@ti.com>
References: <1349117226-4980-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <20121002032106.GP4840@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Lokesh Vutla <lokeshvutla@ti.com> [121001 11:48]:
> Patch 1:
> 	Dropping the file plat/dma44xx.h as none of the omap44xx
> 	dma channel definitions are used.
> Patch 2:
> 	Moving OMAP1 DMA channel definitions to mach-omap1
> Patch 3:
> 	Moving OMAP2+ DMA channel definitions to mach-omap2
> Patch 4:
> 	Moving plat/dma.h to plat-omap/dma-omap.h
> Patch 5:
> 	Removing omap_reserve() callback from all omap1 board files.
> Patch 6:
> 	Defining omap_reserve() locally to mach-omap2.
> Patch 7:
> 	Move plat/omap-secure.h locally to mach-omap2
> 
> Lokesh Vutla (7):
>   ARM: OMAP: DMA: Removing plat/dma-44xx.h
>   ARM: OMAP1: DMA: Moving OMAP1 DMA channel definitions to mach-omap1
>   ARM: OMAP2+: DMA: Moving OMAP2 DMA channel definitions to mach-omap2
>   ARM: OMAP: DMA: Move plat/dma.h to plat-omap/dma-omap.h
>   ARM: OMAP1: Remove omap_reserve() callback for all omap1 boards
>   ARM: OMAP2+: Move omap_reserve() locally to mach-omap2
>   ARM: OMAP: Move plat/omap-secure.h locally to mach-omap2

Thanks, I'll be applying these probably at -rc1. If anybody
has better ideas for the move of plat/dma.h to plat-omap/dma-omap.h,
please yell out now.

Regards,

Tony
