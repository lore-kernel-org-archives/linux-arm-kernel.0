From: broonie@kernel.org (Mark Brown)
Date: Wed, 3 Dec 2014 20:19:05 +0000
Subject: [PATCH 4/5] ASoC: dwc: Add devicetree support for Designware I2S
In-Reply-To: <2041200.ZjakFFAZAU@wuerfel>
References: <547F3CAC.9050105@arm.com>
 <2041200.ZjakFFAZAU@wuerfel>
Message-ID: <20141203201905.GO7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 03, 2014 at 09:13:18PM +0100, Arnd Bergmann wrote:

> I don't think we even have to worry about the platform_data case here:
> the only platform using this hardware in Linux is arm/mach-spear, and
> it defines a device node with a binding that is similar to the one you
> document here but that is not implemented in the driver.

Not all the world uses DT, this is a DesignWare IP so it's likely to get
deployed widely - potentially on PCI cards and things like that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141203/be4d7bfa/attachment.sig>
