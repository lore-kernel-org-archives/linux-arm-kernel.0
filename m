From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 21 Sep 2013 21:00:00 +0100
Subject: [PATCH 24/51] DMA-API: dma: pl330: add
 dma_set_mask_and_coherent() call
In-Reply-To: <201309201926.29084.heiko@sntech.de>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMm5t-0007i5-V7@rmk-PC.arm.linux.org.uk>
 <201309201926.29084.heiko@sntech.de>
Message-ID: <20130921200000.GS25647@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 20, 2013 at 07:26:27PM +0200, Heiko St?bner wrote:
> Am Donnerstag, 19. September 2013, 23:49:01 schrieb Russell King:
> > The DMA API requires drivers to call the appropriate dma_set_mask()
> > functions before doing any DMA mapping.  Add this required call to
> > the AMBA PL08x driver.
> 			^--- copy and paste error - should of course be PL330

Fixed, thanks.
