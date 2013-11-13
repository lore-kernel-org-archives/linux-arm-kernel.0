From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 13 Nov 2013 10:30:17 +0530
Subject: [PATCH] dmaengine: Add support for BCM2835.
In-Reply-To: <20131108181743.GR2493@sirena.org.uk>
References: <527D1DDA.2040004@koalo.de> <20131108181743.GR2493@sirena.org.uk>
Message-ID: <20131113050017.GO8834@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 08, 2013 at 06:17:43PM +0000, Mark Brown wrote:
> On Fri, Nov 08, 2013 at 06:22:34PM +0100, Florian Meier wrote:
> > Add support for DMA controller of BCM2835 as used in the Raspberry Pi.
> > Currently it only supports cyclic DMA for serving the I2S driver.
> 
> Adding in Martin Sperl who's been looking at DMA with regard to the SPI
> controller (which will want non-cyclic mode but I guess there's a lot of
> shared code).
Is there a plan to add a library in SPI for dma ops, on lines of what is done in
sound?

--
~Vinod
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131113/6c9175fe/attachment.sig>
