From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Feb 2013 10:48:03 +0000
Subject: [PATCH 01/12] ARM: dts: add generic DMA device tree binding for
 mxs-dma
In-Reply-To: <20130228063911.GD26106@S2101-09.ap.freescale.net>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
 <201302272036.05123.arnd@arndb.de>
 <20130228063911.GD26106@S2101-09.ap.freescale.net>
Message-ID: <201302281048.03225.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 February 2013, Shawn Guo wrote:
> On Wed, Feb 27, 2013 at 08:36:04PM +0000, Arnd Bergmann wrote:
> > Looks good overall, just one small comment: The generic binding requires both
> > "dma-channels" and "dma-requests" to be listed here.
> 
> Hmm, what I read from Documentation/devicetree/bindings/dma/dma.txt is
> that both dma-channels and dma-requests are optional properties.
> 

Ah, you are right. Nevermind then.

	Arnd
