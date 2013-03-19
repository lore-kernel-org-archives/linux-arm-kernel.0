From: marex@denx.de (Marek Vasut)
Date: Tue, 19 Mar 2013 11:33:33 +0100
Subject: [PATCH] ARM: video: mxs: Fix mxsfb misconfiguring VDCTRL0
In-Reply-To: <20130319054846.GI12462@S2101-09.ap.freescale.net>
References: <CAOMZO5CDuODRrJEEaDKm5nepfkuvuF77ZQmarB69hL6gg386ww@mail.gmail.com>
 <201303181619.52377.marex@denx.de>
 <20130319054846.GI12462@S2101-09.ap.freescale.net>
Message-ID: <201303191133.33879.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Mon, Mar 18, 2013 at 04:19:52PM +0100, Marek Vasut wrote:
> > Dear Shawn Guo,
> > 
> > > On Mon, Mar 18, 2013 at 03:18:13PM +0100, Marek Vasut wrote:
> > > > Did you manage to test it please?
> > > 
> > > I do not have X11 environment handy to test, but framework console
> > > seems still working.
> > 
> > Even after me poking in it, lol :-)
> > 
> > You can grab [1], extract it onto card or NFS and just use it as root
> > filesystem, the X11 will come up automagically.
> 
> Thanks, Marek.  Yeah, now I can see the problem and your patch does fix
> it.

Whew, cool. Can you please apply it and push mainline so I can re-send the one 
for -stable then?

Thank you!

Best regards,
Marek Vasut
