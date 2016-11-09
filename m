From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Nov 2016 14:47:18 -0700
Subject: [PATCH v2 0/5] ARM: OMAP: dead code removal
In-Reply-To: <1478268138-7044-1-git-send-email-Nicolae_Rosia@mentor.com>
References: <1478000206-10855-1-git-send-email-Nicolae_Rosia@mentor.com>
 <1478268138-7044-1-git-send-email-Nicolae_Rosia@mentor.com>
Message-ID: <20161109214718.GE2428@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolae Rosia <Nicolae_Rosia@mentor.com> [161104 07:02]:
> Hi,
> 
> I have identified some dead code which can be removed.
> 
> v2:
> - Added details on each commit on how the code ended up unused.
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

Thanks applying all these into omap-for-v4.10/legacy.

Regards,

Tony
