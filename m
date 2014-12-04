From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 04 Dec 2014 12:17:15 +0100
Subject: [PATCH 4/5] ASoC: dwc: Add devicetree support for Designware I2S
In-Reply-To: <20141204110746.GR7712@sirena.org.uk>
References: <547F3CAC.9050105@arm.com> <2240364.fL8B0EDbFB@wuerfel>
 <20141204110746.GR7712@sirena.org.uk>
Message-ID: <2090131.rL6S1lx8Ky@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 December 2014 11:07:46 Mark Brown wrote:
> On Thu, Dec 04, 2014 at 10:55:55AM +0100, Arnd Bergmann wrote:
> > On Wednesday 03 December 2014 20:19:05 Mark Brown wrote:
> 
> > > Not all the world uses DT, this is a DesignWare IP so it's likely to get
> > > deployed widely - potentially on PCI cards and things like that.
> 
> > It's not really new though, and we are only seeing the second user.
> > Maybe this one just isn't as common as a lot of the other designware IP?
> 
> It's relatively common with newer companies - it's like UARTs, any
> company that's been around for a long time will have a homebrew IP
> already but places that don't (or get fed up with their existing IP)
> will tend to buy something in.

I see, but are any of the newer designs going to use platform_data?
My general feeling was that the only places that still depend on that
are legacy platforms and architectures.

	Arnd
