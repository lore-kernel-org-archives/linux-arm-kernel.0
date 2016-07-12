From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 12 Jul 2016 10:02:05 +0530
Subject: [PATCH] dmaengine: xilinx: Fix race condition in axi dma cyclic
 dma mode
In-Reply-To: <1468053588-18357-1-git-send-email-appanad@xilinx.com>
References: <1468053588-18357-1-git-send-email-appanad@xilinx.com>
Message-ID: <20160712043204.GN9681@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 09, 2016 at 02:09:48PM +0530, Kedareswara rao Appana wrote:
> In cyclic DMA mode need to link the tail bd segment
> with the head bd segment to process bd's in cyclic.
> 
> Current driver is doing this only for tx channel
> needs to update the same for rx channel case also.

Applied, thanks

-- 
~Vinod
