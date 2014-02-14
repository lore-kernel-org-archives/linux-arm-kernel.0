From: r.sricharan@ti.com (Sricharan R)
Date: Fri, 14 Feb 2014 18:24:56 +0530
Subject: [PATCH 00/26] OMAP dma engine rework
In-Reply-To: <20140210155531.GB26684@n2100.arm.linux.org.uk>
References: <20140210155531.GB26684@n2100.arm.linux.org.uk>
Message-ID: <52FE1220.6090502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 February 2014 09:25 PM, Russell King - ARM Linux wrote:
> This is the current set of patches for the OMAP DMA engine rework,
> which should now work correctly on OMAP1 platforms thanks to Tony's
> testing.
> 
> It would be good to get this validated by others across a range of
> OMAP platforms, and queued up for the next merge window, so it can
> be built upon.
> 
> Acks appreciated, and once sufficient have been added, I'll send a
> pull request for this to Vinod.
> 
>  arch/arm/mach-omap1/dma.c | 191 ++++++--------
>  arch/arm/mach-omap2/dma.c | 183 ++++++-------
>  arch/arm/plat-omap/dma.c  |  17 +-
>  drivers/dma/omap-dma.c    | 659 +++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/omap-dma.h  |  25 +-
>  5 files changed, 784 insertions(+), 291 deletions(-)
> 
Tested this on DRA7XX with MMC peripheral DMA

Regards,
 Sricharan
