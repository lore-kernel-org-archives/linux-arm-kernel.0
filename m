From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 4 May 2015 14:05:45 +0530
Subject: [PATCH] dmaengine: omap-dma: Add support for memcpy
In-Reply-To: <1429688069-31765-1-git-send-email-peter.ujfalusi@ti.com>
References: <1429688069-31765-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20150504083545.GD3521@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 22, 2015 at 10:34:29AM +0300, Peter Ujfalusi wrote:
> The sDMA controller is capable of performing memory copy operation. It need
> to be configured to software triggered mode and without HW synchronization.
> The sDMA can copy data which is aligned to 8, 16 or 32 bits.
Applied, thanks

-- 
~Vinod
