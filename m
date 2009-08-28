From: tony@atomide.com (Tony Lindgren)
Date: Fri, 28 Aug 2009 09:00:49 -0700
Subject: [PATCH 0/2] OMAP: misc. fixes for 2.6.32
In-Reply-To: <1251448127-27336-1-git-send-email-khilman@deeprootsystems.com>
References: <1251448127-27336-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <20090828160049.GI25828@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [090828 01:28]:
> Tony,
> 
> I pushed a couple more fixes to my pm-upstream/fixes-32 branch.  You've
> already pulled this branch into your for-next, so a re-pull will get
> you just these two additional patches.

OK, I need to rebuild the omap for-next as there are few compilation
issues in at least the omap3-upstream series.

Regards,

Tony
 
> Thanks,
> 
> Kevin
> 
> 
> Reddy, Teerth (1):
>   OMAP3: PM: add T2 interrupt line mux setting, and enable on 3430SDP
> 
> Vikram Pandita (1):
>   OMAP: Zoom2: release debug board detect gpio line
> 
>  arch/arm/mach-omap2/board-3430sdp.c         |    6 ++++++
>  arch/arm/mach-omap2/board-zoom-debugboard.c |    7 ++++---
>  arch/arm/mach-omap2/mux.c                   |    5 +++++
>  arch/arm/plat-omap/include/mach/mux.h       |    3 +++
>  4 files changed, 18 insertions(+), 3 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
