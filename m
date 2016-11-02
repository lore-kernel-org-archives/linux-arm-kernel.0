From: stillcompiling@gmail.com (Joshua Clayton)
Date: Wed, 02 Nov 2016 05:51:37 -0700
Subject: [PATCH 0/5] ARM: OMAP: dead code removal
In-Reply-To: <1478000206-10855-1-git-send-email-Nicolae_Rosia@mentor.com>
References: <1478000206-10855-1-git-send-email-Nicolae_Rosia@mentor.com>
Message-ID: <5171695.W4AFPtEAdE@diplodocus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 01, 2016 01:36:41 PM Nicolae Rosia wrote:
> Hi,
> 
> I have identified some dead code which can be removed.
> 
> Nicolae Rosia (5):
>   ARM: OMAP4: kill omap4_pmic_init and omap4_pmic_get_config
>   ARM: OMAP3: kill omap3_pmic_get_config and twl_{get,set}_voltage
>   ARM: OMAP3: kill omap3_pmic_init
>   ARM: OMAP2: kill omap2_pmic_init
>   ARM: OMAP: kill omap_pmic_init
> 
>  arch/arm/mach-omap2/twl-common.c | 483 ---------------------------------------
>  arch/arm/mach-omap2/twl-common.h |  24 --
>  2 files changed, 507 deletions(-)
> 
> 
I think the commit logs for these patches
need a little detail on why the code is
no longer needed. For posterity. 
