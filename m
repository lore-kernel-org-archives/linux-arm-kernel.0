From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 23 Sep 2013 16:13:52 +0530
Subject: [alsa-devel] [PATCH 24/51] DMA-API: dma: pl330: add
 dma_set_mask_and_coherent() call
In-Reply-To: <20130921200000.GS25647@n2100.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMm5t-0007i5-V7@rmk-PC.arm.linux.org.uk>
 <201309201926.29084.heiko@sntech.de>
 <20130921200000.GS25647@n2100.arm.linux.org.uk>
Message-ID: <20130923104352.GK17188@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 21, 2013 at 09:00:00PM +0100, Russell King - ARM Linux wrote:
> On Fri, Sep 20, 2013 at 07:26:27PM +0200, Heiko St?bner wrote:
> > Am Donnerstag, 19. September 2013, 23:49:01 schrieb Russell King:
> > > The DMA API requires drivers to call the appropriate dma_set_mask()
> > > functions before doing any DMA mapping.  Add this required call to
> > > the AMBA PL08x driver.
> > 			^--- copy and paste error - should of course be PL330
> 
> Fixed, thanks.
with fixed changelog...

Acked-by: Vinod Koul <vinod.koul@intel.com>

~Vinod

-- 
