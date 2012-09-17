From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Mon, 17 Sep 2012 15:30:21 +0530
Subject: [PATCH v3 05/15] dmaengine: omap-dma: Add support to suppress
 interrupts in cyclic mode
In-Reply-To: <1347624358-25582-6-git-send-email-peter.ujfalusi@ti.com>
References: <1347624358-25582-1-git-send-email-peter.ujfalusi@ti.com>
 <1347624358-25582-6-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1347876021.1943.149.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-09-14 at 15:05 +0300, Peter Ujfalusi wrote:
> When requested (DMA_PREP_INTERRUPT is cleared in flags) disable all
> DMA
> interrupts for the channel. In this mode user space does not expect
> periodic reports from kernel about the progress of the audio stream.
> PulseAudio for example support this type of mode.
Acked-by: Vinod Koul <vinod.koul@linux.intel.com>

-- 
~Vinod
