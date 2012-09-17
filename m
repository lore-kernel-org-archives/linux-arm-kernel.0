From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Mon, 17 Sep 2012 15:28:59 +0530
Subject: [PATCH v3 03/15] dmaengine: Add flags parameter to
 dmaengine_prep_dma_cyclic()
In-Reply-To: <1347624358-25582-4-git-send-email-peter.ujfalusi@ti.com>
References: <1347624358-25582-1-git-send-email-peter.ujfalusi@ti.com>
 <1347624358-25582-4-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1347875939.1943.147.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-09-14 at 15:05 +0300, Peter Ujfalusi wrote:
> With this parameter added to dmaengine_prep_dma_cyclic() the API will
> be in
> sync with other dmaengine_prep_*() functions.
> The dmaengine_prep_dma_cyclic() function primarily used by audio for
> cyclic
> transfer required by ALSA, we use the from audio to ask dma drivers to
> suppress interrupts (if DMA_PREP_INTERRUPT is cleared) when it is
> supported
> on the platform.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> CC: Lars-Peter Clausen <lars@metafoo.de>
> --- 
Acked-by: Vinod Koul <vinod.koul@linux.intel.com>


-- 
~Vinod
