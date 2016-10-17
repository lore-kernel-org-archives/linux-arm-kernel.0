From: olof@lixom.net (Olof Johansson)
Date: Mon, 17 Oct 2016 13:47:22 -0700
Subject: [GIT PULL] ARM: mvebu: fixes for v4.8 (#3)
In-Reply-To: <6481361.Tzq3EBKYRj@wuerfel>
References: <87intq5z0o.fsf@free-electrons.com> <4853532.G9HOlQ47QA@wuerfel>
 <87insrf8aw.fsf@free-electrons.com> <6481361.Tzq3EBKYRj@wuerfel>
Message-ID: <20161017204722.GC3264@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 03:42:30PM +0200, Arnd Bergmann wrote:
> On Monday, October 17, 2016 2:51:03 PM CEST Gregory CLEMENT wrote:
> > Hi Arnd,
> >  
> >  On mer., sept. 21 2016, Arnd Bergmann <arnd@arndb.de> wrote:
> > 
> > > On Tuesday, September 20, 2016 6:14:47 PM CEST Gregory CLEMENT wrote:
> > >> mvebu fixes for 4.8 (part 3)
> > >> 
> > >> - Select corediv clk for all mvebu v7 SoC
> > >> - Fix clocksource for CP110 master SPI0 for Armada 7K/8K
> > >> 
> > >
> > > Pulled into fixes, thanks!
> > 
> > I don't see this patch in the v4.8 or the v4.9-rc1.
> > 
> > I think it slipped through the cracks as there were the only one in the
> > fixes branches.
> > 
> > Do you think you could make them part of your next pull request for
> > fixes for 4.9-rc2?
> 
> Indeed, I missed how this was still on the fixes branch during
> the merge window. It is still on that branch (and nothing else
> is so far), and it will be part of the next fixes pull request.
> 
> Thanks for the reminder.

I've re-merged it since I wanted to forward the fixes branch to
v4.9-rc1, but I've made sure it's applied again.

Agreed, thanks for the reminder.


-Olof
