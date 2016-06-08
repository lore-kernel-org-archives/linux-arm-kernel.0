From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 8 Jun 2016 09:07:30 +0530
Subject: [PATCH] dmaengine: bcm2835: fix unexported function
In-Reply-To: <1465316096-6025-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465316096-6025-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20160608033730.GS16910@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 05:14:56PM +0100, Ben Dooks wrote:
> The bcm2835_dma_prep_dma_memcpy() function is not exported
> outside the driver, so make it static to avoid the following
> warning:

Applied, thanks

-- 
~Vinod
