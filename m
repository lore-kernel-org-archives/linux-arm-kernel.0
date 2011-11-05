From: tony@atomide.com (Tony Lindgren)
Date: Fri, 4 Nov 2011 17:40:24 -0700
Subject: [GIT PULL] ARM: OMAP: PRCM/SCM/hwmod miscellaneous fixes for 3.2
In-Reply-To: <alpine.DEB.2.00.1110070318120.4611@utopia.booyaka.com>
References: <alpine.DEB.2.00.1110070318120.4611@utopia.booyaka.com>
Message-ID: <20111105004024.GO31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [111007 01:45]:
> Hi Tony,
> 
> The following changes since commit be73246058737beec52ae232bcab7776332a9e06:
> 
>   ARM: OMAP2+: Remove custom init_irq for remaining boards (2011-09-26 17:50:37 -0700)
> 
> are available in the git repository at:
>   git://git.pwsan.com/linux-2.6 prcm_scm_misc_fixes_3.2

Pulling into fixes.

Tony
 
> Abhilash K V (1):
>       ARM: OMAP: AM35x: remove hwmods that aren't generic
> 
> Archit Taneja (1):
>       ARM: OMAP: ctrl: Fix CONTROL_DSIPHY register fields
> 
>  .../include/mach/ctrl_module_pad_core_44xx.h       |    8 ++++----
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   13 ++++++++-----
>  2 files changed, 12 insertions(+), 9 deletions(-)
> 
> 
> - Paul
