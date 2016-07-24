From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 24 Jul 2016 11:15:09 +0530
Subject: [PATCH] dmaengine: omap-dma: Support for interleaved transfer
In-Reply-To: <20160712112114.8478-1-peter.ujfalusi@ti.com>
References: <20160712112114.8478-1-peter.ujfalusi@ti.com>
Message-ID: <20160724054509.GS9681@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2016 at 02:21:14PM +0300, Peter Ujfalusi wrote:
> Initial support for interleaved transfer with sDMA.
> The implementation only supports DMA_MEM_TO_MEM and frame_size must be 1.
> sDMA needs to be configured for double indexing when ICG is needed.

Applied, thanks

-- 
~Vinod
