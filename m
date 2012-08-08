From: Dongjin.Kim@agreeyamobility.net (Dongjin Kim)
Date: Wed, 8 Aug 2012 02:41:03 +0000
Subject: =?utf-8?B?7ZqM7IugOiBbUEFUQ0ggdjJdIE9EUk9JRC1YOiBoa2RrNDQxMjogQWRkIG5l?=
 =?utf-8?Q?w_hardware_based_on_Exynos4412?=
In-Reply-To: <0a4301cd750c$cd29d2e0$677d78a0$%kim@samsung.com>
References: <1344262254-14648-1-git-send-email-dongjin.kim@agreeyamobility.net>
 <1344365401-18591-1-git-send-email-dongjin.kim@agreeyamobility.net>,
 <0a4301cd750c$cd29d2e0$677d78a0$%kim@samsung.com>
Message-ID: <A6A3B7488C419F488E5B13FFD03C08AD2F43CB39@BL2PRD0510MB363.namprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thank you for your advice.

And I didn't know non-DT board file will not be merged any more.
Rule is rule, I can manage the file in my git only.

I am very new to send git patches to open community, even I use git on my previous project.
I will pay attention to my next patches if I have more. :)

Thanks again.

Regards,
Dongjin.
________________________________________
?? ??: Kukjin Kim [kgene.kim at samsung.com]
?? ??: 2012? 8? 8? ??? ?? 11:23
?? ??: 'Dongjin Kim'
??: Dongjin Kim; 'Russell King'; 'Tony Lindgren'; 'Jon Medhurst'; 'Shawn Guo'; 'Uwe Kleine-K?nig'; linux-arm-kernel at lists.infradead.org; linux-samsung-soc at vger.kernel.org; linux-kernel at vger.kernel.org
??: RE: [PATCH v2] ODROID-X: hkdk4412: Add new hardware based on Exynos4412

Dongjin Kim wrote:
>
Hi,

Basically, we don't add more board file for non-DT for EXYNOS SoCs...

> The HKDK4412 is the CPU module developed by Hardkernel which is based on
> Exynos 4412.  mach_hkdk4412.c is to run on ODROID-X hardware and Machine
> ID
> (4289) is registered.
>
This should be done at the link: http://www.arm.linux.org.uk/developer/machines/ by Russell King.

But I'm not sure whether it is worth to you without this patch for board file in mainline.

> Changes in v2:
>   -. Change regulator's display names
>
> Change-Id: Iea6825a17b2e13f96bc6d892dd5135cad899b5df

No need gerrit Change-Id here.

> Signed-off-by: Dongjin Kim <dongjin.kim@agreeyamobility.net>

If there is no reason, please use same e-mail address in the field of author and sign-off.

Note, if you want to use e-mail 'agreeyamobility.net', just add 'From: Dongjin Kim <dongjin.kim@agreeyamobility.net>', it's ok.

> ---
>  arch/arm/mach-exynos/Kconfig         |   23 +
>  arch/arm/mach-exynos/Makefile        |    1 +
>  arch/arm/mach-exynos/mach-hkdk4412.c |  964
> ++++++++++++++++++++++++++++++++++
>  arch/arm/tools/mach-types            |    1 +
>  4 files changed, 989 insertions(+)
>  create mode 100644 arch/arm/mach-exynos/mach-hkdk4412.c
>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
