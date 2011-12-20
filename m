From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 20 Dec 2011 14:54:04 +0530
Subject: [PATCH 0/4] Fix the left DMA_NONE from dma_transfer_direction
 migration
In-Reply-To: <1323791286-29574-1-git-send-email-shawn.guo@linaro.org>
References: <1323791286-29574-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1324373044.1641.10096.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-12-13 at 23:48 +0800, Shawn Guo wrote:
> I have been working on -rc recently, and have not noticed the failure
> until I ran next tree today.  The mxs-mmc driver is broken on next
> tree because the DMA_NONE was left over from the dma_transfer_direction
> migration for mxs-dma and its client drivers.
> 
For DMA transfer, the NONE direction makes no sense?

In your conetext, what are you trying to achieve?


-- 
~Vinod
