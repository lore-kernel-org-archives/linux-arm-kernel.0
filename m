From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 08 Aug 2012 11:23:30 +0900
Subject: [PATCH v2] ODROID-X: hkdk4412: Add new hardware based on
 Exynos4412
In-Reply-To: <1344365401-18591-1-git-send-email-dongjin.kim@agreeyamobility.net>
References: <1344262254-14648-1-git-send-email-dongjin.kim@agreeyamobility.net>
 <1344365401-18591-1-git-send-email-dongjin.kim@agreeyamobility.net>
Message-ID: <0a4301cd750c$cd29d2e0$677d78a0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
