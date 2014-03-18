From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 18 Mar 2014 21:18:45 +0530
Subject: [PATCH 00/26] OMAP dma engine rework
In-Reply-To: <20140210155531.GB26684@n2100.arm.linux.org.uk>
References: <20140210155531.GB26684@n2100.arm.linux.org.uk>
Message-ID: <20140318154845.GE1976@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 09:25:31PM +0530, Russell King - ARM Linux wrote:
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
So is this series finalized. I havent seen the pull request for this or did i
miss it!

-- 
~Vinod
> 
>  arch/arm/mach-omap1/dma.c | 191 ++++++--------
>  arch/arm/mach-omap2/dma.c | 183 ++++++-------
>  arch/arm/plat-omap/dma.c  |  17 +-
>  drivers/dma/omap-dma.c    | 659 +++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/omap-dma.h  |  25 +-
>  5 files changed, 784 insertions(+), 291 deletions(-)
> 
> -- 
> FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
> in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
> Estimate before purchase was "up to 13.2Mbit".

-- 
