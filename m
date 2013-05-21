From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 21 May 2013 10:27:27 +0900
Subject: [PATCH] ARM: EXYNOS: Fix support of Exynos4210 rev0 SoC
In-Reply-To: <1623377.nVo7nUcid2@flatron>
References: <1368630484-29939-1-git-send-email-t.figa@samsung.com>
 <1623377.nVo7nUcid2@flatron>
Message-ID: <0f8101ce55c2$5b084c90$1118e5b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> Hi Kukjin,
> 
Hi,

> On Wednesday 15 of May 2013 17:08:04 Tomasz Figa wrote:
> > This patch extends exynos_init_time() function to handle Exynos4210 rev0
> > SoC, which differs in availability of system timers and needs different
> > clocksource initialization.
> >
> > This makes it possible to use exynos_init_time() function as init_time
> > callback for all Exynos-based boards, including Universal_C210, which
> > originally had to use samsung_timer_init().
> >
> > Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  arch/arm/mach-exynos/Kconfig               |  3 ++-
> >  arch/arm/mach-exynos/common.c              | 30
> > +++++++++++++++++++++++++++++- arch/arm/mach-exynos/common.h
> >   |  2 ++
> >  arch/arm/mach-exynos/mach-universal_c210.c |  5 ++---
> >  4 files changed, 35 insertions(+), 5 deletions(-)
> 
> Could you pick this patch to your fixes branch?
> 
Yeah, I will after looking at.

> This is a fix of a regression in handling Exynos4210 rev0 SoC (e.g.
> Universal C210 board) introduced by patches merged to 3.10.
> 
OK, I see but I didn't review yet and I  will within a couple of days ;-)

- Kukjin
