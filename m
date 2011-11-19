From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 Nov 2011 16:05:04 -0800
Subject: [PATCH 0/2] ARM: OMAP: misc. PM fixes for v3.2-rc
In-Reply-To: <20111118234415.GS31337@atomide.com>
References: <1321644160-19981-1-git-send-email-khilman@ti.com>
 <20111118234415.GS31337@atomide.com>
Message-ID: <20111119000504.GU31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [111118 15:09]:
> * Kevin Hilman <khilman@ti.com> [111118 10:47]:
> > Tony,
> > 
> > Here's a couple more PM fixes for v3.2-rc.
> > 
> > Also available here if you prefer to pull:
> > 
> >    git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.2/fixes/pm
> > 
> > (Note that this branch also includes the CPUidle fix that you already have
> >  in your fixes branch)
> 
> This leads into the same commit showing up twice since it's now
> applied in two different trees. Can you please rebase your branch
> on the current fixes?

Thanks for updating it, pulling in the fixed branch.

Tony


> > Felipe Balbi (1):
> >   arm: omap: smartreflex: fix IRQ handling bug
> > 
> > Kevin Hilman (1):
> >   ARM: OMAP: PM: only register TWL with voltage layer when device is
> >     present
> > 
> >  arch/arm/mach-omap2/pm.c          |    6 ++----
> >  arch/arm/mach-omap2/smartreflex.c |    2 +-
> >  arch/arm/mach-omap2/twl-common.c  |   11 +++++++++++
> >  arch/arm/mach-omap2/twl-common.h  |    3 +++
> >  4 files changed, 17 insertions(+), 5 deletions(-)
> > 
> > -- 
> > 1.7.6
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
