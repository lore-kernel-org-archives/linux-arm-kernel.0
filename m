From: leilk.liu@mediatek.com (leilk liu)
Date: Thu, 6 Aug 2015 09:45:40 +0800
Subject: [PATCH v4 1/3] dt-binding: spi: Mediatek: Document devicetree
 bindings for spi bus
In-Reply-To: <20150804174226.GE20873@sirena.org.uk>
References: <1438167874-1305-1-git-send-email-leilk.liu@mediatek.com>
 <1438167874-1305-2-git-send-email-leilk.liu@mediatek.com>
 <20150804174226.GE20873@sirena.org.uk>
Message-ID: <1438825540.2163.5.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-08-04 at 18:42 +0100, Mark Brown wrote:
> On Wed, Jul 29, 2015 at 07:04:32PM +0800, Leilk Liu wrote:
> > Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> 
> Please use subject lines reflecting the style for the subsystem so
> people can spot if patches are relevant to them.
> 

OK, I will change the title to "spi: Mediatek: Document devicetree
bindings for spi bus".

> > +- clocks: phandles to input clocks.
> > +
> > +- clock-names: tuple listing input clock names.
> > +	Required elements: "main"
> 
> ...and there are no optional values?
> 

clock tree provides some source clocks, CLK_PERI_SPI0 is the default
one. I will support optional values on the next version.

> > +- pad-select: should specify spi pad used, only required for MT8173.
> > +        This value should be 0~3.
> 
> What do the values 0-3 mean?  I guess it's the value for some register
> or other part of the device, the binding should say so people can go and
> check the datasheet, schematic or whatever to figure out what to set.
> 
> This property should be optional, not required

OK, I will explain what the values 0-3 mean.
