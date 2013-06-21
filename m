From: mgr@pengutronix.de (Michael Grzeschik)
Date: Fri, 21 Jun 2013 14:22:31 +0200
Subject: Chipidea usb otg support for IMX/MXS (device functionality)
In-Reply-To: <201306211326.11175.marex@denx.de>
References: <51A5A808.2070803@digi.com>
 <F281D0F91ED19E4D8E63A7504E8A649803E8A4D0@039-SN2MPN1-021.039d.mgd.msft.net>
 <20130529101332.GC7356@pengutronix.de>
 <201306211326.11175.marex@denx.de>
Message-ID: <20130621122231.GD3523@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Fri, Jun 21, 2013 at 01:26:10PM +0200, Marek Vasut wrote:
> Hi,
> 
> > Hi,
> > 
> > On Wed, May 29, 2013 at 08:07:55AM +0000, Chen Peter-B29397 wrote:
> > > > Indeed, I've been using the patchset "Add tested id switch and vbus
> > > > connect detect support for Chipidea" from Peter for quite some time on
> > > > top of 3.9 and it works like a charm for the gadget mode on an MX28
> > > > platform.
> > > > 
> > > > BTW, Peter, I've seen that these patches are still not merged in 3.10,
> > > > is there a reason for that? do you plan on sending a version rebased on
> > > > top of 3.10 some time in the future? I tried to do the rebasing myself,
> > > > but the chipidea driver seems to have changed quite heavily, which
> > > > makes the process quite difficult when you don't know what you're
> > > > doing :)
> > 
> > we already have Peter's patches on v3.10-rc3 [1].
> > 
> > > I can spend few bandwidth on upstream work recently, I may have more
> > > bandwidth after June 15th.
> > > 
> > > Currently, we still have no conclusion for chipidea core driver's coming
> > > work, like Device tree support, how to identify if the controller is OTG
> > > supported.
> > 
> > Yes, the next important step is getting the of propertys "dr_mode" and
> > "phy_type" properly used in the chipidea core.
> > 
> > [1] http://git.pengutronix.de/?p=mgr/linux.git;a=summary ->
> > v3.10/topic/usb-peterchen
> 
> Is anyone planning to work on this stuff and start pushing it mainline or is 
> this effort stalled completely? What is it that's missing before these can be 
> applied?

AFAIK the latest commit to that work is:

http://permalink.gmane.org/gmane.linux.usb.general/88121

Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
