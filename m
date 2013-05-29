From: maxime.ripard@free-electrons.com (maxime.ripard at free-electrons.com)
Date: Wed, 29 May 2013 14:19:16 +0200
Subject: Chipidea usb otg support for IMX/MXS (device functionality)
In-Reply-To: <20130529101332.GC7356@pengutronix.de>
References: <51A5A808.2070803@digi.com>
 <F281D0F91ED19E4D8E63A7504E8A649803E8A3F3@039-SN2MPN1-021.039d.mgd.msft.net>
 <20130529075044.GC3293@lukather>
 <F281D0F91ED19E4D8E63A7504E8A649803E8A4D0@039-SN2MPN1-021.039d.mgd.msft.net>
 <20130529101332.GC7356@pengutronix.de>
Message-ID: <20130529121916.GF3293@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On Wed, May 29, 2013 at 12:13:32PM +0200, Michael Grzeschik wrote:
> Hi,
> 
> On Wed, May 29, 2013 at 08:07:55AM +0000, Chen Peter-B29397 wrote:
> > 
> >  
> > > 
> > > Indeed, I've been using the patchset "Add tested id switch and vbus
> > > connect detect support for Chipidea" from Peter for quite some time on
> > > top of 3.9 and it works like a charm for the gadget mode on an MX28
> > > platform.
> > > 
> > > BTW, Peter, I've seen that these patches are still not merged in 3.10,
> > > is there a reason for that? do you plan on sending a version rebased on
> > > top of 3.10 some time in the future? I tried to do the rebasing myself,
> > > but the chipidea driver seems to have changed quite heavily, which makes
> > > the process quite difficult when you don't know what you're doing :)
> > > 
> 
> we already have Peter's patches on v3.10-rc3 [1].

Wow, great, thanks!

> > I can spend few bandwidth on upstream work recently, I may have more
> > bandwidth after June 15th. 
> > 
> > Currently, we still have no conclusion for chipidea core driver's coming work,
> > like Device tree support, how to identify if the controller is OTG supported.
> 
> Yes, the next important step is getting the of propertys "dr_mode" and
> "phy_type" properly used in the chipidea core.

I totally admit lacking some context here, but how does the device tree
move prevent from merging these patches? Do they have any shortcomings?
I've been using them with DT for quite some time and it seems to be
working pretty well if you ask me...

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
