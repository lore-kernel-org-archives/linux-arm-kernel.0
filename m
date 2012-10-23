From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 23 Oct 2012 07:16:57 -0400
Subject: [PATCH] arm: mvebu: support for the PlatHome OpenBlocks AX3 board
In-Reply-To: <20121023104534.1d4ff689@skate>
References: <1350980365-6698-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121023084241.GV11837@lunn.ch> <20121023104534.1d4ff689@skate>
Message-ID: <20121023111657.GB18811@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 10:45:34AM +0200, Thomas Petazzoni wrote:
> Dear Andrew Lunn,
> 
> On Tue, 23 Oct 2012 10:42:41 +0200, Andrew Lunn wrote:
> > > diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
> > > index 49d7915..cd2717b 100644
> > > --- a/arch/arm/mach-mvebu/armada-370-xp.c
> > > +++ b/arch/arm/mach-mvebu/armada-370-xp.c
> > > @@ -49,6 +49,7 @@ static void __init armada_370_xp_dt_init(void)
> > >  static const char * const armada_370_xp_dt_board_dt_compat[] = {
> > >  	"marvell,a370-db",
> > >  	"marvell,axp-db",
> > > +	"plathome,openblocks-ax3",
> > >  	NULL,
> > >  };
> > 
> > Hi Thomas
> > 
> > You will get less merge conflicts with new boards if you keep this
> > list sorted.
> 
> Hum, right, but isn't "plathome" after "marvell" when sorted
> alphabetically? Or maybe I don't get which kind of sorting you are
> referring to?

No, no, no.  marvell, /then/ NULL, /then/ plathome.  ;-)  Right, Andrew?

thx,

Jason.
