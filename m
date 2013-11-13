From: broonie@kernel.org (Mark Brown)
Date: Wed, 13 Nov 2013 12:51:11 +0000
Subject: [PATCH] dmaengine: Add support for BCM2835.
In-Reply-To: <20131113050017.GO8834@intel.com>
References: <527D1DDA.2040004@koalo.de> <20131108181743.GR2493@sirena.org.uk>
 <20131113050017.GO8834@intel.com>
Message-ID: <20131113125111.GE878@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 13, 2013 at 10:30:17AM +0530, Vinod Koul wrote:
> On Fri, Nov 08, 2013 at 06:17:43PM +0000, Mark Brown wrote:

> > Adding in Martin Sperl who's been looking at DMA with regard to the SPI
> > controller (which will want non-cyclic mode but I guess there's a lot of
> > shared code).

> Is there a plan to add a library in SPI for dma ops, on lines of what
> is done in sound?

I'm probably going to be looking at that at some point, though perhaps
Martin will get to it since he seems to be looking at this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131113/dab1c29c/attachment.sig>
