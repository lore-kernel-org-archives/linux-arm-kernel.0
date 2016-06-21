From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 21 Jun 2016 21:25:02 +0530
Subject: [PATCH 2/4] dmaengine: vdma: Add support for mulit-channel dma
 mode
In-Reply-To: <1465549954-30220-3-git-send-email-appanad@xilinx.com>
References: <1465549954-30220-1-git-send-email-appanad@xilinx.com>
 <1465549954-30220-3-git-send-email-appanad@xilinx.com>
Message-ID: <20160621155502.GB16910@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2016 at 02:42:32PM +0530, Kedareswara rao Appana wrote:
> This patch adds support for AXI DMA multi-channel dma mode
> Multichannel mode enables DMA to connect to multiple masters
> And slaves on the streaming side.
> In Multichannel mode AXI DMA supports 2D transfers.

Funny formatting!

Can you elobrate what you meant by Multichannel mode? This patch seems to do
two things, one is to add interleaved dma support and something else. Can
you explain the latter part?

>  /**
> + * struct xilinx_mcdma_config - DMA Multi channel configuration structure
> + * @tdest: Channel to operate on
> + * @tid:   Channel configuration
> + * @tuser: Tuser configuration
> + * @ax_user: ax_user value
> + * @ax_cache: ax_cache value
> + */
> +struct xilinx_mcdma_config {
> +	u8 tdest;
> +	u8 tid;
> +	u8 tuser;
> +	u8 ax_user;
> +	u8 ax_cache;

can you describe these in details, what do these do, what are the values to
be programmed?

-- 
~Vinod
