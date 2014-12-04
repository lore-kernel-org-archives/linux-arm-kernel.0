From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 04 Dec 2014 10:55:55 +0100
Subject: [PATCH 4/5] ASoC: dwc: Add devicetree support for Designware I2S
In-Reply-To: <20141203201905.GO7712@sirena.org.uk>
References: <547F3CAC.9050105@arm.com> <2041200.ZjakFFAZAU@wuerfel>
 <20141203201905.GO7712@sirena.org.uk>
Message-ID: <2240364.fL8B0EDbFB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 December 2014 20:19:05 Mark Brown wrote:
> On Wed, Dec 03, 2014 at 09:13:18PM +0100, Arnd Bergmann wrote:
> 
> > I don't think we even have to worry about the platform_data case here:
> > the only platform using this hardware in Linux is arm/mach-spear, and
> > it defines a device node with a binding that is similar to the one you
> > document here but that is not implemented in the driver.
> 
> Not all the world uses DT, this is a DesignWare IP so it's likely to get
> deployed widely - potentially on PCI cards and things like that.

It's not really new though, and we are only seeing the second user.
Maybe this one just isn't as common as a lot of the other designware IP?



	Arnd
