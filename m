From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 28 Jun 2016 20:10:13 +0530
Subject: [PATCH] dmaengine: ti-dma-crossbar: make omap_dmaxbar_init static
In-Reply-To: <1466529159-10359-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466529159-10359-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20160628144013.GE14945@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 06:12:39PM +0100, Ben Dooks wrote:
> The omap_dmaxbar_init() function is not exported or declared outside
> the driver, so make it static to fix the following sparse warning:
> 
> drivers/dma/ti-dma-crossbar.c:455:5: warning: symbol 'omap_dmaxbar_init' was not declared. Should it be static?

Applied, thanks

-- 
~Vinod
