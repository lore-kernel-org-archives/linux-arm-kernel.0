From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Mon, 17 Sep 2012 15:29:27 +0530
Subject: [PATCH v3 04/15] dmaengine: Pass flags via
 device_prep_dma_cyclic() callback
In-Reply-To: <1347624358-25582-5-git-send-email-peter.ujfalusi@ti.com>
References: <1347624358-25582-1-git-send-email-peter.ujfalusi@ti.com>
 <1347624358-25582-5-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1347875967.1943.148.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-09-14 at 15:05 +0300, Peter Ujfalusi wrote:
> Change the parameter list of device_prep_dma_cyclic() so the DMA
> drivers
> can receive the flags coming from clients.
> This feature can be used during audio operation to disable all audio
> related interrupts when the DMA_PREP_INTERRUPT is cleared from the
> flags.
Acked-by: Vinod Koul <vinod.koul@linux.intel.com>

-- 
~Vinod
