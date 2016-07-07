From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 Jul 2016 11:48:25 +0200
Subject: [PATCH 2/2] dt-bindings: spi: add binding for clps711x SPI
In-Reply-To: <20160707092546.GJ6247@sirena.org.uk>
References: <20160706145326.2658600-1-arnd@arndb.de>
 <20160706145326.2658600-2-arnd@arndb.de>
 <20160707092546.GJ6247@sirena.org.uk>
Message-ID: <3501318.cujsGY8KyD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 7, 2016 11:25:46 AM CEST Mark Brown wrote:
> On Wed, Jul 06, 2016 at 04:53:13PM +0200, Arnd Bergmann wrote:
> > This documents the binding used by Alexander Shiyan's DT support for
> > the clps711x SPI controller.
> 
> Please use subject lines matching the style for the subsystem.  This
> makes it easier for people to identify relevant patches.

I tried, though it's a bit tricky for dt-bindings. When I created the
patch, using 'dt-bindings: $SUBSYSTEM' appeared to be the most common
one, ahead of '$SUBSYSTEM' (mainly used for combined patches)
and other random prefixes.

I'll resend it with just 'spi:', but I don't think there is a broad
consensus on this in the existing patches.

	Arnd
