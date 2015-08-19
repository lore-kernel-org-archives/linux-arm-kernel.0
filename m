From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 19 Aug 2015 21:21:54 +0530
Subject: [PATCH] dmaengine: at_xdmac: fix bug in prep_dma_cyclic
In-Reply-To: <1437574349-13816-1-git-send-email-ludovic.desroches@atmel.com>
References: <1437574349-13816-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20150819155154.GC13546@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 22, 2015 at 04:12:29PM +0200, Ludovic Desroches wrote:
> In cyclic mode, the round chaining has been broken by the introduction
> of at_xdmac_queue_desc(): AT_XDMAC_MBR_UBC_NDE is set for all descriptors
> excepted for the last one. at_xdmac_queue_desc() has to be called one
> more time to chain the last and the first descriptors.

Applied, thanks

-- 
~Vinod
