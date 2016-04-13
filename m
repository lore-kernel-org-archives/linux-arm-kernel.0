From: broonie@kernel.org (Mark Brown)
Date: Wed, 13 Apr 2016 18:20:20 +0100
Subject: [PATCH v3] spi: orion.c: Add direct access mode
In-Reply-To: <570E3010.10309@denx.de>
References: <1460030811-13787-1-git-send-email-sr@denx.de>
 <20160411105740.GB3351@sirena.org.uk> <570CDF5F.9070106@denx.de>
 <20160412192736.GC14664@sirena.org.uk> <570DD967.8010703@denx.de>
 <20160413055946.GH14664@sirena.org.uk> <570E3010.10309@denx.de>
Message-ID: <20160413172020.GB29471@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2016 at 01:40:00PM +0200, Stefan Roese wrote:
> On 13.04.2016 07:59, Mark Brown wrote:

> >  It also seems like we need to document what
> > the meaning of the reg properties of the device is, it's all very well
> > saying that there's a generic MBus binding but we still need to say how
> > the device will interpret the MBus windows that it has (assuming they
> > are configured to specific hardware functions transparently).

> Should I add something to the bindings documentation of
> the orion-spi driver? With an example of how this direct mode
> can is enabled on a specific board for e.g. SPI0-DEV1? Or what do
> you think is missing in the mbus bindings documentation I
> mentioned above?

I think the biggest thing that's missing is a reference from the Orion
binding to the MBus binding that the reader can follow (probably added
to the reg property documentation).  I did look there and couldn't see
anything about how this would work.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160413/9731a27a/attachment.sig>
