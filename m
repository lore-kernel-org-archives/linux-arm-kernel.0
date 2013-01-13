From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 12 Jan 2013 20:30:14 -0500
Subject: [GIT PULL 4/4] ARM: mvebu: dt for v3.9
In-Reply-To: <20130113010658.GT23505@n2100.arm.linux.org.uk>
References: <pull-1358033364-983365> <E1TuAWi-0004H4-K6@merlin.infradead.org>
 <20130113010658.GT23505@n2100.arm.linux.org.uk>
Message-ID: <20130113013014.GN13433@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 13, 2013 at 01:06:58AM +0000, Russell King - ARM Linux wrote:
> On Sat, Jan 12, 2013 at 11:29:24PM +0000, Jason Cooper wrote:
> > The following changes since commit d1c3ed669a2d452cacfb48c2d171a1f364dae2ed:
> > 
> >   Linux 3.8-rc2 (2013-01-02 18:13:21 -0800)
> > 
> > are available in the git repository at:
> > 
> >   git://git.infradead.org/users/jcooper/linux.git tags/dt_for_v3.9
> > 
> > for you to fetch changes up to 877ddfac50bfeabc4729d0b8ac41989d226148b9:
> > 
> >   ARM: Dove: add fixed regulator for CuBox USB power (2013-01-12 22:35:56 +0000)
> > 
> > ----------------------------------------------------------------
> > mvebu dt changes for v3.9
> >  - mvebu
> >    - add rtc support
> >    - add sdio support
> >  - kirkwood
> >    - add sdio support
> >    - add twsi1 and nand to 88f6282
> >    - convert openblocks A6 to pinctrl
> >  - dove
> >    - move led pinctrl to gpio-leds node
> >    - use fixed regulator for usb power
> 
> And a note specified dependency on previous pull requests...

oops, you're right.  I'll update them in V2 after we get the mvsdio
driver in better shape.

thx,

Jason.
