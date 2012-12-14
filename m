From: tony@atomide.com (Tony Lindgren)
Date: Fri, 14 Dec 2012 11:06:53 -0800
Subject: [PATCH 0/2] ARM: OMAP2420: Fix ethernet support
In-Reply-To: <1352844140-11103-1-git-send-email-jon-hunter@ti.com>
References: <1352844140-11103-1-git-send-email-jon-hunter@ti.com>
Message-ID: <20121214190653.GK4989@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jon Hunter <jon-hunter@ti.com> [121113 14:04]:
> Fix ethernet support for OMAP2420 and remove legacy code for ethernet
> configuration.

Thanks applying both into omap-for-v3.8/fixes-for-merge-window.

Regards,

Tony
 
> Jon Hunter (2):
>   ARM: OMAP2420: Fix ethernet support for OMAP2420 H4
>   ARM: OMAP: Remove debug-devices.c
> 
>  arch/arm/mach-omap2/board-h4.c      |   80 +++++++-----------------------
>  arch/arm/mach-omap2/debug-devices.h |    9 ----
>  arch/arm/plat-omap/Makefile         |    1 -
>  arch/arm/plat-omap/debug-devices.c  |   93 -----------------------------------
>  4 files changed, 19 insertions(+), 164 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/debug-devices.h
>  delete mode 100644 arch/arm/plat-omap/debug-devices.c
> 
> -- 
> 1.7.9.5
> 
