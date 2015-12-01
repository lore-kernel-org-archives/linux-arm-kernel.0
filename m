From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Dec 2015 23:55:27 +0100
Subject: [PATCH 0/5] ARM: orion5x/dove/mv78xx0 multiplatform
In-Reply-To: <20151201225126.GB5542@lunn.ch>
References: <1448466557-435335-1-git-send-email-arnd@arndb.de>
 <87610j7gmc.fsf@free-electrons.com> <20151201225126.GB5542@lunn.ch>
Message-ID: <6321642.3Y6UA5fuW5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 December 2015 23:51:26 Andrew Lunn wrote:
> On Mon, Nov 30, 2015 at 02:37:31PM +0100, Gregory CLEMENT wrote:
> > Hi Arnd,
> >  
> >  On mer., nov. 25 2015, Arnd Bergmann <arnd@arndb.de> wrote:
> > 
> > > I've posted these before and now gotten around to a rebase and
> > > want to include them in the arm-soc next/multiplatform branch for
> > > 4.5.
> > >
> > > Originally the plan for these platforms was to convert all of
> > > them to DT and use only mach-mvebu. That has not happened,
> > > so I would do it this way instead so we can at least have
> > > them in a single kernel.
> > >
> > > Let me know if there are any concerns or objections.
> > 
> > I have applied all the patches on mvebu/oldmvebu_multiplatform (I fixed
> > the last one which didn't apply on Kconfig). I also merged it
> > mvebu/for-netx to be part of the linux-next.
> > 
> > But before making it part of mvebu/soc, I would like to get some
> > Tested-by. The series is available on
> > git://git.infradead.org/linux-mvebu.git
> > in the branch mvebu/oldmvebu_multiplatform but it also will be part soon
> > of linux-next.
> 
> Hi Gregory
> 
> I blew the dust of my Orion5x NAS Reference Design. It boots.
> 
> Tested-by: Andrew Lunn <andrew@lunn.ch>

Thanks for testing!

> It would be nice to make Orion5x part of the multi_v5_defconfig and
> mvebu_v5_defconfig. I will see about cooking up some patches.

Good idea.

	Arnd
