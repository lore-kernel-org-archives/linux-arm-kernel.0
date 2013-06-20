From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jun 2013 20:45:37 +0200
Subject: [GIT PULL] picoxcell cleanups for 3.11
In-Reply-To: <20130620145744.GC8641@page>
References: <20130611122621.GA9967@page> <201306201624.09841.arnd@arndb.de>
 <20130620145744.GC8641@page>
Message-ID: <201306202045.37994.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 June 2013, Jamie Iles wrote:
> > > > ----------------------------------------------------------------
> > > > Jamie Iles (1):
> > > >       picoxcell: remove redundant common.h
> > > > 
> > > > Maxime Ripard (1):
> > > >       ARM: picoxcell: Remove init_irq declaration in machine description
> > 
> > I got a regression since NR_IRQS_LEGACY is not defined with the headers
> > removed.
> > 
> > I think we can just remove this line as well, since NR_IRQS_LEGACY is
> > the default anyway.
> > 
> > Does that work?
> 
> I can't reproduce the failure here with my config, I guess it's getting 
> included through one of the other includes.  Either way, your fix looks 
> good to me.

I only saw the problem in allmodconfig, not multi_v7_defconfig.

Applied the fix now with your Ack.

	Arnd
