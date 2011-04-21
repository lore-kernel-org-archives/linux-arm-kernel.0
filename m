From: tony@atomide.com (Tony Lindgren)
Date: Thu, 21 Apr 2011 01:59:18 -0700
Subject: [PATCH] omap: Run make savedefconfig on omap2plus_defconfig to
	shrink it
In-Reply-To: <20110421085303.GN31131@pengutronix.de>
References: <20110421064423.GD13688@atomide.com>
	<20110421082328.GK31131@pengutronix.de>
	<20110421084910.GF13688@atomide.com>
	<20110421085303.GN31131@pengutronix.de>
Message-ID: <20110421085918.GG13688@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> [110421 01:49]:
> On Thu, Apr 21, 2011 at 01:49:10AM -0700, Tony Lindgren wrote:
> > * Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> [110421 01:20]:
> > > On Wed, Apr 20, 2011 at 11:44:23PM -0700, Tony Lindgren wrote:
> > > > This shrinks it down a bit more and makes it easier
> > > > to patch later on.
> > > Maybe pointing out why it's shrinkable would be nice.
> > > E.g.
> > > 
> > > 	After commit
> > > 
> > > 		ffb63e3 (omap2/3/4: Select all omaps and boards by default
> > > 
> > > 	many explicit settings can be dropped from the defconfig.
> > 
> > Good point, updated patch below.
> > 
> > Regards,
> > 
> > Tony
> > 
> > 
> > From: Tony Lindgren <tony@atomide.com>
> > Date: Wed, 20 Apr 2011 23:37:06 -0700
> > Subject: [PATCH] omap: Run make savedefconfig on omap2plus_defconfig to shrink it
> > 
> > After commit ffb63e3 (omap2/3/4: Select all omaps and boards by default)
> > may explicit settings can be dropped from the defconfig.
> s/may/many/

Oops, thanks will update.
 
> I think ffb63e3 doesn't explain all changes, but ok.

Yeah..

Tony
