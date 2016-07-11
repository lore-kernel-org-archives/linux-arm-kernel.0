From: robh@kernel.org (Rob Herring)
Date: Mon, 11 Jul 2016 09:42:38 -0500
Subject: [PATCH 2/2] dt-bindings: spi: add binding for clps711x SPI
In-Reply-To: <3501318.cujsGY8KyD@wuerfel>
References: <20160706145326.2658600-1-arnd@arndb.de>
 <20160706145326.2658600-2-arnd@arndb.de>
 <20160707092546.GJ6247@sirena.org.uk> <3501318.cujsGY8KyD@wuerfel>
Message-ID: <20160711144238.GA10877@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2016 at 11:48:25AM +0200, Arnd Bergmann wrote:
> On Thursday, July 7, 2016 11:25:46 AM CEST Mark Brown wrote:
> > On Wed, Jul 06, 2016 at 04:53:13PM +0200, Arnd Bergmann wrote:
> > > This documents the binding used by Alexander Shiyan's DT support for
> > > the clps711x SPI controller.
> > 
> > Please use subject lines matching the style for the subsystem.  This
> > makes it easier for people to identify relevant patches.
> 
> I tried, though it's a bit tricky for dt-bindings. When I created the
> patch, using 'dt-bindings: $SUBSYSTEM' appeared to be the most common
> one, ahead of '$SUBSYSTEM' (mainly used for combined patches)
> and other random prefixes.

There isn't. Mark and I don't agree here as the former is my 
preference, but I care less than he does. :) 

Rob
