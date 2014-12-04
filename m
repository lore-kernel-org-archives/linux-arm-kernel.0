From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Dec 2014 11:33:46 +0000
Subject: [PATCH 4/5] ASoC: dwc: Add devicetree support for Designware I2S
In-Reply-To: <2090131.rL6S1lx8Ky@wuerfel>
References: <547F3CAC.9050105@arm.com> <2240364.fL8B0EDbFB@wuerfel>
 <20141204110746.GR7712@sirena.org.uk> <2090131.rL6S1lx8Ky@wuerfel>
Message-ID: <20141204113346.GT7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 04, 2014 at 12:17:15PM +0100, Arnd Bergmann wrote:
> On Thursday 04 December 2014 11:07:46 Mark Brown wrote:

> > It's relatively common with newer companies - it's like UARTs, any
> > company that's been around for a long time will have a homebrew IP
> > already but places that don't (or get fed up with their existing IP)
> > will tend to buy something in.

> I see, but are any of the newer designs going to use platform_data?
> My general feeling was that the only places that still depend on that
> are legacy platforms and architectures.

And x86 which does have things like PCI cards.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141204/e36f4d68/attachment.sig>
