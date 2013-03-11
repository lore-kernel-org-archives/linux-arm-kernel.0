From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Mon, 11 Mar 2013 08:53:30 +0000
Subject: [PATCH v2 1/4] spi/davinci: add DT binding documentation
In-Reply-To: <201303051932.41327.arnd@arndb.de>
References: <1362401955-9616-1-git-send-email-prakash.pm@ti.com>
 <6918845.dALXSKksQd@wuerfel>
 <A73F36158E33644199EB82C5EC81C7BC3EA4854E@DBDE01.ent.ti.com>
 <201303051932.41327.arnd@arndb.de>
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA48A6D@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 06, 2013 at 01:02:41, Arnd Bergmann wrote:
> On Tuesday 05 March 2013, Manjunathappa, Prakash wrote:
> > On Mon, Mar 04, 2013 at 21:59:16, Arnd Bergmann wrote:
> > > On Monday 04 March 2013 18:29:12 Manjunathappa, Prakash wrote:
> > > > +- reg: Offset and length of SPI controller register space
> > > > +- num-cs: Number of chip selects
> > > > +- ti,davinci-spi-intr-line: interrupt line used to connect the SPI
> > > > +	IP to the interrupt controller withn the SoC. Possible values
> > > > +	are 0 and 1. Manual says one of the two possible interrupt
> > > > +	lines can be tied to the interrupt controller. Set this
> > > > +	based on a specifc SoC configuration.
> > > > +- interrupts: interrupt number offset at the irq parent
> > > 
> > > I would not call this an "offset". It is an interrupt descriptor
> > > which may be something other than a simple number.
> > > 
> > 
> > I am planning to drop from this documentation as it is common property.
> 
> I think it makese sense to document the fact that there should be exactly
> one interrupt listed in the interrupts property, especially since the
> hardware has two outputs.
> 

Agreed, will consider this property for documenting.

Thanks,
Prakash
