From: tony@atomide.com (Tony Lindgren)
Date: Sat, 28 Dec 2013 14:09:11 -0800
Subject: [GIT PULL] few omap regression fixes against v3.13-rc5
In-Reply-To: <20131228005747.GE5116@atomide.com>
References: <20131228005747.GE5116@atomide.com>
Message-ID: <20131228220910.GA9523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [131227 16:57]:
> The following changes since commit 413541dd66d51f791a0b169d9b9014e4f56be13c:
> 
>   Linux 3.13-rc5 (2013-12-22 13:08:32 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/intc-ldp-fix
> 
> for you to fetch changes up to 82f4fe707836e80b0fcaae9a4a1756e6e89c5e62:
> 
>   Merge tag 'for-v3.13-rc/hwmod-fixes-b' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into debug-ll-and-ldp-backlight-fix (2013-12-27 09:51:25 -0800)
> 
> ----------------------------------------------------------------
> 
> Fix a regression for wrong interrupt numbers for some devices after
> the sparse IRQ conversion, fix DRA7 console output for earlyprintk,
> and fix the LDP LCD backlight when DSS is built into the kernel and
> not as a loadable module.  

Added also the mailing lists to Cc.

Regards,

Tony
 
> ----------------------------------------------------------------
> Rajendra Nayak (1):
>       ARM: DRA7: hwmod: Fix boot crash with DEBUG_LL
> 
> Suman Anna (1):
>       ARM: OMAP2+: hwmod_data: fix missing OMAP_INTC_START in irq data
> 
> Tony Lindgren (2):
>       ARM: OMAP2+: Fix LCD panel backlight regression for LDP legacy booting
>       Merge tag 'for-v3.13-rc/hwmod-fixes-b' of git://git.kernel.org/.../pjw/omap-pending into debug-ll-and-ldp-backlight-fix
> 
>  arch/arm/mach-omap2/board-ldp.c                    | 7 ++++++-
>  arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c | 4 ++--
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         | 6 +++---
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c          | 2 +-
>  4 files changed, 12 insertions(+), 7 deletions(-)
> 
