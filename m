From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Oct 2018 19:00:02 +0200
Subject: [PATCH v2 01/11] dt-bindings: spi/spi-pxa2xx: add PXA2xx SSP SPI
 Controller
In-Reply-To: <8cafa3f97fbe2a01ccf968b39469751b449e324b.camel@v3.sk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
 <20181010170936.316862-2-lkundrak@v3.sk>
 <20181011142719.GE25351@sirena.org.uk>
 <8cafa3f97fbe2a01ccf968b39469751b449e324b.camel@v3.sk>
Message-ID: <20181012170002.GJ2340@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 11, 2018 at 07:59:15PM +0200, Lubomir Rintel wrote:
> On Thu, 2018-10-11 at 15:27 +0100, Mark Brown wrote:

> > Please use subject lines matching the style for the subsystem.  This
> > makes it easier for people to identify relevant patches.

> Thanks for the response.

> I'm a little confused here. Why I chose this subject line is because I
> did this:

>   git log --no-merges Documentation/devicetree/bindings/

Try Documentation/devicetree/bindings/spi instead :)

> to figure out what's the typical subject for the DT binding changes.

> I also believed that's the right way to get Rob Herring's and Mark
> Rutland's attention. Do the device tree binding documentation typically

There *is* some debate for the DT bindings unfortunately.

> go in with the associated drivers, or via their tree ("OPEN FIRMWARE
> AND FLATTENED DEVICE TREE BINDINGS" in MAINTIANERS)?

They usually go in with the drivers.  This one isn't so bad since it
does mention SPI, it's a worse problem when that's not present at all.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181012/9c449126/attachment.sig>
