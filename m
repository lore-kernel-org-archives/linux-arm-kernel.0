From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Mon, 17 Sep 2012 15:25:42 +0530
Subject: [PATCH v3 02/15] dmaengine: omap: Add support for pause/resume
 in cyclic dma mode
In-Reply-To: <1347624358-25582-3-git-send-email-peter.ujfalusi@ti.com>
References: <1347624358-25582-1-git-send-email-peter.ujfalusi@ti.com>
 <1347624358-25582-3-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1347875742.1943.143.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-09-14 at 15:05 +0300, Peter Ujfalusi wrote:
> The audio stack used omap_stop_dma/omap_start_dma to pause/resume the
> DMA.
> This method has been used for years on OMAP based products.
> We only allow pause/resume when the DMA has been configured in cyclic
> mode
> which is used by the audio stack.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> CC: Russell King <rmk+kernel@arm.linux.org.uk>
> --- 
Acked-by: Vinod Koul <vinod.koul@linux.intel.com>

-- 
~Vinod
