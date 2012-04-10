From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 10 Apr 2012 09:53:19 -0700
Subject: [PATCH] ARM: exynos: add dts files to dtbs target
In-Reply-To: <1333945993-20363-1-git-send-email-olof@lixom.net>
References: <1333945993-20363-1-git-send-email-olof@lixom.net>
Message-ID: <4F84657F.9060008@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> Add the currently in-tree device tree sources to the dtbs target.
> 
> Signed-off-by: Olof Johansson<olof@lixom.net>
> ---
>   arch/arm/mach-exynos/Makefile.boot |    3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-exynos/Makefile.boot b/arch/arm/mach-exynos/Makefile.boot
> index b9862e2..31bd181 100644
> --- a/arch/arm/mach-exynos/Makefile.boot
> +++ b/arch/arm/mach-exynos/Makefile.boot
> @@ -1,2 +1,5 @@
>      zreladdr-y	+= 0x40008000
>   params_phys-y	:= 0x40000100
> +
> +dtb-$(CONFIG_MACH_EXYNOS4_DT) += exynos4210-origen.dtb exynos4210-smdkv310.dtb
> +dtb-$(CONFIG_MACH_EXYNOS5_DT) += exynos5250-smdk5250.dtb

Applied, thanks.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
