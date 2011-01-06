From: tony@atomide.com (Tony Lindgren)
Date: Thu, 6 Jan 2011 14:43:26 -0800
Subject: [PATCH 5/5] omap2+: pm_bus: make functions used as pointers as
	static
In-Reply-To: <87zkrg2nfa.fsf@ti.com>
References: <1294171634-13943-1-git-send-email-nm@ti.com>
	<1294171634-13943-6-git-send-email-nm@ti.com>
	<87zkrg2nfa.fsf@ti.com>
Message-ID: <20110106224326.GC7771@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [110104 16:39]:
> Nishanth Menon <nm@ti.com> writes:
> 
> > omap_pm_runtime_suspend and omap_pm_runtime_resume are used
> > as function pointers and does not really need to be exposed
> > to the world.
> >
> > Fixes sparse warnings:
> > arch/arm/mach-omap2/pm_bus.c:23:5: warning: symbol 'omap_pm_runtime_suspend' was not declared. Should it be static?
> > arch/arm/mach-omap2/pm_bus.c:40:5: warning: symbol 'omap_pm_runtime_resume' was not declared. Should it be static?
> >
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> 
> Thanks, will queue this one in my pm-fixes branch for 2.6.38-rc.

I'll take patches 1 - 4.

Tony
