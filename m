From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 7 Jun 2016 11:49:10 +0530
Subject: [PATCH v2 2/4] dmaengine: vdma: Use dma_pool_zalloc
In-Reply-To: <1463557653-1687-3-git-send-email-appanad@xilinx.com>
References: <1463557653-1687-1-git-send-email-appanad@xilinx.com>
 <1463557653-1687-3-git-send-email-appanad@xilinx.com>
Message-ID: <20160607061910.GI16910@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 18, 2016 at 01:17:31PM +0530, Kedareswara rao Appana wrote:
> dma_pool_zalloc combines dma_pool_alloc and memset 0
> this patch updates the driver to use dma_pool_zalloc.

Applied, thanks

-- 
~Vinod
