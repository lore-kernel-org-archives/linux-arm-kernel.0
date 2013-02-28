From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Feb 2013 14:39:12 +0800
Subject: [PATCH 01/12] ARM: dts: add generic DMA device tree binding for
 mxs-dma
In-Reply-To: <201302272036.05123.arnd@arndb.de>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
 <1361978748-25281-2-git-send-email-shawn.guo@linaro.org>
 <201302272036.05123.arnd@arndb.de>
Message-ID: <20130228063911.GD26106@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 08:36:04PM +0000, Arnd Bergmann wrote:
> Looks good overall, just one small comment: The generic binding requires both
> "dma-channels" and "dma-requests" to be listed here.

Hmm, what I read from Documentation/devicetree/bindings/dma/dma.txt is
that both dma-channels and dma-requests are optional properties.

Shawn

> My understanding of this
> driver is that each channel is hardwired to one request, so you can mandate here
> that the two values must be the same.
