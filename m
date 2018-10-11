From: lkundrak@v3.sk (Lubomir Rintel)
Date: Thu, 11 Oct 2018 19:59:15 +0200
Subject: [PATCH v2 01/11] dt-bindings: spi/spi-pxa2xx: add PXA2xx SSP
 SPI Controller
In-Reply-To: <20181011142719.GE25351@sirena.org.uk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
 <20181010170936.316862-2-lkundrak@v3.sk>
 <20181011142719.GE25351@sirena.org.uk>
Message-ID: <8cafa3f97fbe2a01ccf968b39469751b449e324b.camel@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-10-11 at 15:27 +0100, Mark Brown wrote:
> On Wed, Oct 10, 2018 at 07:09:26PM +0200, Lubomir Rintel wrote:
> > This is the SPI controller found on Marvel MMP2 and perhaps more
> > platforms.
> 
> *Way* more.
> 
> Please use subject lines matching the style for the subsystem.  This
> makes it easier for people to identify relevant patches.

Thanks for the response.

I'm a little confused here. Why I chose this subject line is because I
did this:

  git log --no-merges Documentation/devicetree/bindings/

to figure out what's the typical subject for the DT binding changes.

I also believed that's the right way to get Rob Herring's and Mark
Rutland's attention. Do the device tree binding documentation typically
go in with the associated drivers, or via their tree ("OPEN FIRMWARE
AND FLATTENED DEVICE TREE BINDINGS" in MAINTIANERS)?

Lubo
