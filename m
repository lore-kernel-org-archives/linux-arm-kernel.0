From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Mon, 05 Sep 2011 19:00:14 +0530
Subject: [PATCH] dmaengine: amba-pl08x: make filter check that the
	channel is owned by pl08x
In-Reply-To: <20110831083435.GD26905@n2100.arm.linux.org.uk>
References: <20110831083435.GD26905@n2100.arm.linux.org.uk>
Message-ID: <1315229414.26251.79.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-08-31 at 09:34 +0100, Russell King - ARM Linux wrote:
> Before converting the dma channel to our private data structure, first
> check that the channel is indeed one which our driver registered.  We
> do this by ensuring that the underlying device is bound to our driver.
> 
> This avoids potential oopses if we try to reference 'plchan->name'
> against a foreign drivers dma channel.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Applied, Thanks

-- 
~Vinod
