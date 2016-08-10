From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 10 Aug 2016 23:02:36 +0530
Subject: [PATCH v2 0/6] dmaengine:omap-dma: Linked List transfer for
 slave_sg
In-Reply-To: <20160720085032.2955-1-peter.ujfalusi@ti.com>
References: <20160720085032.2955-1-peter.ujfalusi@ti.com>
Message-ID: <20160810173235.GI9681@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2016 at 11:50:26AM +0300, Peter Ujfalusi wrote:
> Hi,
> 
> Changes since v1:
> - dropped the patch changing the sequence of vchan_cookie_complete and
>   omap_dma_start_sg in omap_dma_callback
> - Use appropriate macros to find omap_chan and omap_desc in patch 6
> - Use per-device pool instead of per-channel pools.
> 
> The following series with the final patch will add support for sDMA Linked List
> transfer support.
> Linked List is supported by sDMA in OMAP3630+ (OMAP4/5, dra7 family).
> If the descriptor load feature is present we can create the descriptors for each
> SG beforehand and let sDMA to walk them through.
> This way the number of sDMA interrupts the kernel need to handle will drop
> dramatically.

Applied all, thanks

-- 
~Vinod
