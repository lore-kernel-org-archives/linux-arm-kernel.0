From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 29 Nov 2011 20:23:19 +0100
Subject: [PATCH 0/6] AT91 Reset cleanup
In-Reply-To: <20111129190726.GM9581@n2100.arm.linux.org.uk>
References: <20111129173514.GW15008@game.jcrosoft.org>
 <201111291946.13719.marek.vasut@gmail.com>
 <20111129190726.GM9581@n2100.arm.linux.org.uk>
Message-ID: <201111292023.19202.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Tue, Nov 29, 2011 at 07:46:13PM +0100, Marek Vasut wrote:
> > > On Tue, Nov 29, 2011 at 06:35:14PM +0100, Jean-Christophe
> > > PLAGNIOL-VILLARD
> > 
> > wrote:
> > > > Hi,
> > > > 
> > > > 	the following patch series will merge the ddr controler header 
file
> > > > 	for sam9 and cap9 and cleanup the reset by
> > > > 	
> > > > 	swtich to arm_pm_restart
> > > > 	fix the sam9g45 and cap9 reset
> > > > 	make rstc soc independent
> > > > 
> > > > The following changes since commit 
15327570807209b5c088382af23ed3fc47558d87:
> > > >   ARM: at91/gpio: fix display of number of irq setuped (2011-11-28
> > > >   22:53:09 +0800)
> > > > 
> > > > are available in the git repository at:
> > > >   git://github.com/at91linux/linux-at91.git for-arnd-3.3-reset
> > > > 
> > > > Jean-Christophe PLAGNIOL-VILLARD (6):
> > > >       ARM: at91: fix cap9 ddrsdr register
> > > >       ARM: at91: merge at91cap9_ddrsdr.h in at91sam9_ddrsdr.h
> > > >       ARM: at91: introduce AT91_SAM9_ALT_RESET to select the at91sam9
> > > >       alternative reset ARM: restart: at91: use new restart hook
> > > 
> > > Well, it looks like you've taken my work here and committed it as
> > > yourself. That's plagerism.  Don't do it - and fix it before someone
> > > pulls your crap.
> > 
> > Hey,
> > 
> > looking at the patch in question, it looks so trivial the clash is just
> > possible. Why not just put two SoB lines there and maybe From: and be
> > done with it?
> 
> Look closer.  The patch which was posted has my sign-off on it, it says
> it's from me, but according to the commit summary, it's author is Jean-
> Christophe.
> 
> So, it _is_ my patch which Jean has decided to _recommit_ into his tree
> taking it from my tree _without_ _asking_ _me_ whether it was either a
> good idea to do that, whether it was a finished patch, etc.

Ah ok, I see.
> 
> So all in all I'm pretty disgusted with Jean-Christophe over this.

Oh come on, calm down. Just keep an eye on him so he won't do it again and be 
done with it ;-) And Jean should certainly drop the patch if it's unfinished 
stuff.
> 
> I would like to see my patch updated at some point not to use
> arm_pm_restart, but to use the .restart method directly, like I've been
> doing for everyone else.  In other words, this patch is NOT STABLE at
> the present time.

OK
