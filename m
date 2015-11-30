From: tony@atomide.com (Tony Lindgren)
Date: Mon, 30 Nov 2015 15:04:46 -0800
Subject: [PATCH 1/7] ARM: omap1: make headers more local
In-Reply-To: <1448924458-3279040-2-git-send-email-arnd@arndb.de>
References: <1448924458-3279040-1-git-send-email-arnd@arndb.de>
 <1448924458-3279040-2-git-send-email-arnd@arndb.de>
Message-ID: <20151130230445.GN23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [151130 15:02]:
> Some header files are never included outside of a mach-omap1
> directory and do not need to be made visible in include/mach,
> so let's just move them all down one level.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-omap1/board-ams-delta.c              | 2 +-
>  arch/arm/mach-omap1/board-fsample.c                | 2 +-
>  arch/arm/mach-omap1/board-h2.c                     | 2 +-
>  arch/arm/mach-omap1/board-h3.c                     | 2 +-
>  arch/arm/mach-omap1/board-innovator.c              | 2 +-
>  arch/arm/mach-omap1/board-osk.c                    | 2 +-
>  arch/arm/mach-omap1/board-palmte.c                 | 2 +-
>  arch/arm/mach-omap1/board-palmtt.c                 | 2 +-
>  arch/arm/mach-omap1/board-palmz71.c                | 2 +-
>  arch/arm/mach-omap1/board-perseus2.c               | 2 +-
>  arch/arm/mach-omap1/board-sx1-mmc.c                | 2 +-
>  arch/arm/mach-omap1/board-sx1.c                    | 4 ++--
>  arch/arm/mach-omap1/{include/mach => }/board-sx1.h | 0
>  arch/arm/mach-omap1/{include/mach => }/camera.h    | 0
>  arch/arm/mach-omap1/devices.c                      | 2 +-
>  arch/arm/mach-omap1/flash.c                        | 2 +-
>  arch/arm/mach-omap1/{include/mach => }/flash.h     | 0
>  17 files changed, 15 insertions(+), 15 deletions(-)
>  rename arch/arm/mach-omap1/{include/mach => }/board-sx1.h (100%)
>  rename arch/arm/mach-omap1/{include/mach => }/camera.h (100%)
>  rename arch/arm/mach-omap1/{include/mach => }/flash.h (100%)

Looks good to me:

Acked-by: Tony Lindgren <tony@atomide.com>
