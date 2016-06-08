From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 8 Jun 2016 09:03:19 +0530
Subject: [PATCH] dmaengine: at_xdmac: fix un-exported functions
In-Reply-To: <1465315755-3645-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465315755-3645-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20160608033319.GQ16910@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 05:09:15PM +0100, Ben Dooks wrote:
> The at_xdmac_init_used_desc() and at_xdmac_prep_dma_memset()
> functions are not exported outside the driver, so make them
> static to avoid the following warnings:

Applied, thanks

-- 
~Vinod
