From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 24 Jul 2016 11:21:07 +0530
Subject: [PATCH v2] dmaengine: zynqmp_dma: Fix static checker warning
In-Reply-To: <1468503055-20197-1-git-send-email-appanad@xilinx.com>
References: <1468503055-20197-1-git-send-email-appanad@xilinx.com>
Message-ID: <20160724055107.GT9681@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2016 at 07:00:55PM +0530, Kedareswara rao Appana wrote:
> This patch fixes the below static checker warning
> drivers/dma/xilinx/zynqmp_dma.c:973 zynqmp_dma_chan_probe()
>         warn: was && intended here instead of ||?

Applied, thanks

-- 
~Vinod
