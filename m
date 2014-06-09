From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 9 Jun 2014 10:06:12 +0800
Subject: [PATCH] dt/documentation: add specification of dma bus information
In-Reply-To: <1401981720-6946-1-git-send-email-santosh.shilimkar@ti.com>
References: <1401981720-6946-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20140609020611.GW8860@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 05, 2014 at 11:22:00AM -0400, Santosh Shilimkar wrote:
> Recently we introduced the generic device tree infrastructure for couple of DMA
> bus parameter, dma-ranges and dma-coherent. Update the documentation so that
> its useful for future users.
> 
> The "dma-ranges" property is intended to be used for describing the
> configuration of DMA bus RAM addresses and its offset w.r.t CPU addresses.
> 
> The "dma-coherent" property is intended to be used for identifying devices
> supported coherent DMA operations.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Shawn Guo <shawn.guo@freescale.com>
> Cc: Kumar Gala <galak@codeaurora.org>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks for the documentation.  I think it's definitely useful for future
users of the binding.

Acked-by: Shawn Guo <shawn.guo@freescale.com>
