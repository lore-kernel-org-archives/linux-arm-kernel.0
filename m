From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 26 Jul 2012 12:57:15 +0100
Subject: Orion Pull request
In-Reply-To: <201207260707.45157.arnd@arndb.de>
References: <20120724081732.GR18778@lunn.ch> <201207251420.48634.arnd@arndb.de>
 <20120725211740.GD13619@lunn.ch> <201207260707.45157.arnd@arndb.de>
Message-ID: <20120726115714.GA7306@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 07:07:44AM +0000, Arnd Bergmann wrote:
> On Wednesday 25 July 2012, Andrew Lunn wrote:

> > If i make the branches based on the -rc7 release, how do i test them?
> > The patches have dependencies on the I2C patch now accepted by the I2C
> > maintainer and the SPI patches accepted by the SPI maintainer.  These
> > patches implement the DT support in the drivers. Without those
> > patches, all i2c devices are missing, and worst still, the root FS is
> > missing on my Kirkwood QNAP device i test with.

> You can merge the i2c and spi branches that went upstream into your
> own branch before applying your own patches. This way, they become
> "dependencies" and should get merged before yours are sent (in this
> case they already are)

But only if they're stable branches that won't get rebased - always
check with the subsystem maintainers about this.
