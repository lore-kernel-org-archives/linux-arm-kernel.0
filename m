From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 Nov 2011 15:44:16 -0800
Subject: [PATCH 0/2] ARM: OMAP: misc. PM fixes for v3.2-rc
In-Reply-To: <1321644160-19981-1-git-send-email-khilman@ti.com>
References: <1321644160-19981-1-git-send-email-khilman@ti.com>
Message-ID: <20111118234415.GS31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [111118 10:47]:
> Tony,
> 
> Here's a couple more PM fixes for v3.2-rc.
> 
> Also available here if you prefer to pull:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.2/fixes/pm
> 
> (Note that this branch also includes the CPUidle fix that you already have
>  in your fixes branch)

This leads into the same commit showing up twice since it's now
applied in two different trees. Can you please rebase your branch
on the current fixes?

Regards,

Tony
 
> Kevin
> 
> Felipe Balbi (1):
>   arm: omap: smartreflex: fix IRQ handling bug
> 
> Kevin Hilman (1):
>   ARM: OMAP: PM: only register TWL with voltage layer when device is
>     present
> 
>  arch/arm/mach-omap2/pm.c          |    6 ++----
>  arch/arm/mach-omap2/smartreflex.c |    2 +-
>  arch/arm/mach-omap2/twl-common.c  |   11 +++++++++++
>  arch/arm/mach-omap2/twl-common.h  |    3 +++
>  4 files changed, 17 insertions(+), 5 deletions(-)
> 
> -- 
> 1.7.6
> 
