From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Nov 2010 16:58:47 -0800
Subject: [PATCH 0/2] combine zoom board-files
In-Reply-To: <1289199375-9001-1-git-send-email-balbi@ti.com>
References: <1289199375-9001-1-git-send-email-balbi@ti.com>
Message-ID: <20101109005847.GY9264@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [101107 22:45]:
> Those boards are so similar they don't deserve
> separate board files.
> 
> Felipe Balbi (2):
>   arm: omap: combine zoom2 and zoom3 board-files
>   arm: omap: zoom: substitute gpio number with symbolic name
> 
>  arch/arm/mach-omap2/Makefile                       |    4 +-
>  .../arm/mach-omap2/{board-zoom3.c => board-zoom.c} |  104 ++++++++++-------
>  arch/arm/mach-omap2/board-zoom2.c                  |  117 --------------------
>  3 files changed, 64 insertions(+), 161 deletions(-)
>  rename arch/arm/mach-omap2/{board-zoom3.c => board-zoom.c} (75%)
>  delete mode 100644 arch/arm/mach-omap2/board-zoom2.c

Thanks, queuing both for 2.6.38 merge window.

Tony
