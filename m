From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 12 Jan 2013 20:28:32 -0500
Subject: [GIT PULL 2/4] ARM: mvebu: drivers for v3.9
In-Reply-To: <20130113010535.GR23505@n2100.arm.linux.org.uk>
References: <pull-1358033364-983365> <E1TuAWu-0004Jx-Hn@merlin.infradead.org>
 <20130113010535.GR23505@n2100.arm.linux.org.uk>
Message-ID: <20130113012832.GM13433@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 13, 2013 at 01:05:35AM +0000, Russell King - ARM Linux wrote:
> On Sat, Jan 12, 2013 at 11:29:16PM +0000, Jason Cooper wrote:
> > Thomas Petazzoni (4):
> >       mmc: mvsdio: use slot-gpio infrastructure for write protect gpio
> >       mmc: mvsdio: use slot-gpio for card detect gpio
> >       mmc: mvsdio: implement a Device Tree binding
> >       mmc: mvsdio: add pinctrl integration
> 
> Does this include the fixes for the really broken stuff in that driver?
> If not, hold off on this until it's fixed.  The current state of the
> driver is rather BROKEN and it needs fixing in -rc.  It would be best
> to get it fixed there _then_ base development on top of that to avoid
> conflicts.

Ahh, I found the thread you were referring to.  I'll take a look at it
tonight or tomorrow.

thx,

Jason.
