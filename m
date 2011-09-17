From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 17 Sep 2011 04:51:56 +0200
Subject: READ THIS: the next mach-types update
In-Reply-To: <20110916073159.GC22533@n2100.arm.linux.org.uk>
References: <20110915102528.GI6267@n2100.arm.linux.org.uk>
	<20110915145022.GM28104@game.jcrosoft.org>
	<20110916073159.GC22533@n2100.arm.linux.org.uk>
Message-ID: <20110917025156.GO28104@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08:31 Fri 16 Sep     , Russell King - ARM Linux wrote:
> On Thu, Sep 15, 2011 at 04:50:22PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 11:25 Thu 15 Sep     , Russell King - ARM Linux wrote:
> > > I'm going to be merging a mach-types update (the cut-down and the
> > > policy-conforming version) for the next merge window.  This will mean
> > > that things WILL BREAK, and I will not notice that things have broken.
> > > 
> > > In order to fix this, entries need to be fixed to conform to the
> > > requirements - where the machine_is_xxx() name is the same as the
> > > MACH_TYPE_xxx name and the CONFIG_MACH_xxx name too.
> > > 
> > > Moreover, entries older than 12 months which have not been merged will
> > > be removed.  It is not possible to automatically check for machine_is_xxx()
> > > usages as these could conflict with other architectures, and I'm
> > > certainly NOT checking for them by hand (I estimate that'd take a
> > > significant amount of manual effort to do.)  What that means is that it
> > > is _important_ to get the core platform support in _first_ before any
> > > drivers which may make use of this.
> > > 
> > > The following will be deleted from the file this time around are:
> > > -ts_x09                  MACH_TS209              TS209                   1565
> > > -at572d940hfek           MACH_AT572D940HFEB      AT572D940HFEB           1783
> > can be dropped the at572d940hfek as the at572d940hf is drop from mainline
> > 
> > Russell an you confirm you will re-add the usb-a9g20 and the folowing one
> > 
> > usb_a9g20               MACH_USB_A9G20          USB_A9G20               1841
> > qil_a9g20               MACH_QIL_A9G20          QIL_A9G20               1844
> > tny_a9260               MACH_TNY_A9260          TNY_A9260               2058
> > tny_a9g20               MACH_TNY_A9G20          TNY_A9G20               2059
> > tny_a9263               MACH_TNY_A9263          TNY_A9263               2140
> 
> Here's the two relevent question:
> 1. have they been submitted or edited within the last 12 months?  No.
> 2. are they merged into mainline?  No.
> 
> So will they be in the update?  No.
agreed but I've receive the hardware just recently so I add them one by one

the usb_a9g20 is the first and already in Arnd tree

so If you can re-add the otherone it will be nice

they will come soon

Best Regards,
J.
