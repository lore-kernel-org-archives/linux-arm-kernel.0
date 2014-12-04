From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Dec 2014 11:07:46 +0000
Subject: [PATCH 4/5] ASoC: dwc: Add devicetree support for Designware I2S
In-Reply-To: <2240364.fL8B0EDbFB@wuerfel>
References: <547F3CAC.9050105@arm.com> <2041200.ZjakFFAZAU@wuerfel>
 <20141203201905.GO7712@sirena.org.uk> <2240364.fL8B0EDbFB@wuerfel>
Message-ID: <20141204110746.GR7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 04, 2014 at 10:55:55AM +0100, Arnd Bergmann wrote:
> On Wednesday 03 December 2014 20:19:05 Mark Brown wrote:

> > Not all the world uses DT, this is a DesignWare IP so it's likely to get
> > deployed widely - potentially on PCI cards and things like that.

> It's not really new though, and we are only seeing the second user.
> Maybe this one just isn't as common as a lot of the other designware IP?

It's relatively common with newer companies - it's like UARTs, any
company that's been around for a long time will have a homebrew IP
already but places that don't (or get fed up with their existing IP)
will tend to buy something in.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141204/06cc091b/attachment.sig>
