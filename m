From: mgreer@animalcreek.com (Mark A. Greer)
Date: Thu, 18 Oct 2012 15:46:35 -0700
Subject: [RFC] dmaengine: omap-dma: Allow DMA controller to prefetch data
In-Reply-To: <20121018222046.GA28541@animalcreek.com>
References: <20121018222046.GA28541@animalcreek.com>
Message-ID: <20121018224635.GA28751@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2012 at 03:20:46PM -0700, Mark A. Greer wrote:

> This patch seems fairly stable but I've only tested omap-sham (crypto)
> and omap_hsmmc (mmc) on an am37x EVM.  I also enabled burst mode but
> that made the system unstable when exercising either omap-sham or
> omap_hsmmc.  I'm unaware of any errata that would make this an unwanted
> modification but I haven't checked all of the SoCs.  Are there other
> reasons that this should be applied??
                          ^not
