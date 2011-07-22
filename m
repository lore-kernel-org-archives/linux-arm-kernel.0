From: vinod.koul@intel.com (Koul, Vinod)
Date: Fri, 22 Jul 2011 17:37:20 +0530
Subject: [PATCH V4 00/13] To use DMA generic APIs for Samsung DMA
In-Reply-To: <1311158773-30314-1-git-send-email-boojin.kim@samsung.com>
References: <1311158773-30314-1-git-send-email-boojin.kim@samsung.com>
Message-ID: <438BB0150E931F4B9CE701519A4463010871DC9B13@bgsmsx502.gar.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> This patchset adds support DMA generic APIs for Samsung DMA.
> V4 doesn't has whole patch series and only has the patches differed from V3.
> 
> Changes from V3:
> - Divided 03-patch into two patchs.
> 	- First is 03-1-patch for DMA_SLAVE_CONFIG command.
> 	- Another is 03-2-patch for DMA_CYCLIC capability.
> - Code clean-up
> 	- Remove unnecessary variable referance.
> 	- Remove redunancy code
> 
> [PATCH V4 01/13] DMA: PL330: Add support runtime PM for PL330 DMAC
> [PATCH V4 03-1/13] DMA: PL330: Support DMA_SLAVE_CONFIG command
> [PATCH V4 03-2/13] DMA: PL330: Add DMA_CYCLIC capability
> [PATCH V4 05/13] ARM: SAMSUNG: Add common DMA operations

Can you pls send entire patchset again,
it makes things difficult to review patches

~Vinod
