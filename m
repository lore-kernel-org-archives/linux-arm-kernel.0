From: tony@atomide.com (Tony Lindgren)
Date: Wed, 28 Sep 2011 15:12:51 -0700
Subject: [GIT PULL] OMAP: Few sparse/bug fixes and clean-up for 3.2
In-Reply-To: <1316852520-10377-1-git-send-email-santosh.shilimkar@ti.com>
References: <1316852520-10377-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20110928221251.GF6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110924 00:48]:
> Tony,
> 
> Please pull few OMAP sparse/bug fixes and clean-up for 3.2 

Thanks I'll pull these into l3 branch for v3.2 merge window and
merge them into l-o master.

Tony

 
> Thnaks,
> Santosh
> 
> The following changes since commit b6fd41e29dea9c6753b1843a77e50433e6123bcb:
> 
>   Linux 3.1-rc6 (2011-09-12 14:02:02 -0700)
> 
> are available in the git repository at:
>   git://gitorious.org/omap-sw-develoment/linux-omap-dev.git for_3_2/omap_misc
> 
> Santosh Shilimkar (1):
>       OMAP4: Fix the emif and dmm virtual mapping
> 
> Todd Poynor (2):
>       OMAP: Improve register access in L3 Error handler.
>       OMAP: Fix a BUG in l3 error handler.
> 
> sricharan (3):
>       OMAP: Fix indentation issues in l3 error handler.
>       OMAP: Fix sparse warnings in l3 error handler.
>       OMAP: Print Initiator name for l3 custom error.
> 
>  arch/arm/mach-omap2/omap_l3_noc.c    |  130 ++++++++++----------
>  arch/arm/mach-omap2/omap_l3_noc.h    |  224 +++++++++++++++++++---------------
>  arch/arm/mach-omap2/omap_l3_smx.c    |   91 +++++++-------
>  arch/arm/mach-omap2/omap_l3_smx.h    |  164 ++++++++++++------------
>  arch/arm/plat-omap/include/plat/io.h |    4 +-
>  5 files changed, 322 insertions(+), 291 deletions(-)
