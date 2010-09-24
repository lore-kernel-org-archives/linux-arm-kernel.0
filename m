From: tony@atomide.com (Tony Lindgren)
Date: Fri, 24 Sep 2010 16:03:22 -0700
Subject: [GIT PULL] omap: sram fixes and omap4 es2.0 support
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02CD469D0D@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02CD469D0D@dbde02.ent.ti.com>
Message-ID: <20100924230322.GN4211@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [100923 23:24]:
> Tony,
> 
> The following changes since commit b30a3f6257ed2105259b404d419b4964e363928c:
>   Linus Torvalds (1):
>         Linux 2.6.36-rc5
> 
> are available in the git repository at:
> 
>   git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base.git omap_for_2.6.37

Thanks, pulling these into omap-for-linus.

Tony
 
> David Anders (1):
>       omap4: Panda: Add DEBUG_LL support
> 
> Santosh Shilimkar (3):
>       omap4: Update id.c and cpu.h for es2.0
>       omap4: l2x0: Fix init parameter for es2.0
>       omap4: Fix bootup crash observed with higher CPU clocks
> 
> Vikram Pandita (2):
>       omap: sram: fix is_sram_locked check
>       omap4: sram: Fix start address
> 
>  arch/arm/mach-omap2/id.c                     |   38 +++++++++++++++++++++-----
>  arch/arm/mach-omap2/omap4-common.c           |   10 +++++--
>  arch/arm/plat-omap/dmtimer.c                 |    2 +-
>  arch/arm/plat-omap/include/plat/cpu.h        |    5 +++-
>  arch/arm/plat-omap/include/plat/uncompress.h |    1 +
>  arch/arm/plat-omap/sram.c                    |   13 +-------
>  6 files changed, 46 insertions(+), 23 deletions(-)
> 
> Regards,
> Santosh
> (As per thread: http://www.spinics.net/lists/linux-omap/msg37131.html)
