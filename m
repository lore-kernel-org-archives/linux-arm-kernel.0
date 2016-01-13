From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 13 Jan 2016 19:09:51 +0530
Subject: [PATCH] dmaengine: edma: Fix paRAM slot allocation for entry
 channel 0
In-Reply-To: <1452501481-5543-1-git-send-email-peter.ujfalusi@ti.com>
References: <1452501481-5543-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20160113133951.GG11130@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2016 at 10:38:01AM +0200, Peter Ujfalusi wrote:
> edma_alloc_slot was not checking the channel mapping support existence when
> slot 0 has been requested (used as entry slot for channel/event 0).

Applied, thanks

-- 
~Vinod
