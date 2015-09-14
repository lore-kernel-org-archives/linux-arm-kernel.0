From: tony@atomide.com (Tony Lindgren)
Date: Mon, 14 Sep 2015 12:36:56 -0700
Subject: [PATCH 0/4] ARM: OMAP5/DRA7: minor fixes
In-Reply-To: <1441833494-32450-1-git-send-email-nm@ti.com>
References: <1441833494-32450-1-git-send-email-nm@ti.com>
Message-ID: <20150914193656.GX4215@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [150909 14:21]:
> Hi,
> 
> While doing a SoC only build for DRA7, a few bugs did pop up. The
> following series provides necessary fixups for the same.
> 
> Nishanth Menon (4):
>   ARM: OMAP4+: PM: erratum is used by OMAP5 and DRA7 as well
>   ARM: omap2+: board-generic: Remove stale of_irq macros
>   ARM: DRA7: Select missing options for SoC only build
>   ARM: OMAP5: Cleanup options for SoC only build
> 
>  arch/arm/mach-omap2/Kconfig         |    6 +++++-
>  arch/arm/mach-omap2/board-generic.c |    7 -------
>  arch/arm/mach-omap2/pm.h            |    3 ++-
>  3 files changed, 7 insertions(+), 9 deletions(-)

Applying all into omap-for-v4.3/fixes thanks.

Tony
