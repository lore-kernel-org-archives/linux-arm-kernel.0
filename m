From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 7 Jun 2016 11:48:49 +0530
Subject: [PATCH v2 1/4] dmaengine: vdma: Add support for cyclic dma mode
In-Reply-To: <1463557653-1687-2-git-send-email-appanad@xilinx.com>
References: <1463557653-1687-1-git-send-email-appanad@xilinx.com>
 <1463557653-1687-2-git-send-email-appanad@xilinx.com>
Message-ID: <20160607061848.GH16910@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 18, 2016 at 01:17:30PM +0530, Kedareswara rao Appana wrote:
> This patch adds support for AXI DMA cyclic dma mode.
> In cyclic mode, DMA fetches and processes the same
> BDs without interruption. The DMA continues to fetch and process
> until it is stopped or reset.

Applied, thanks

-- 
~Vinod
