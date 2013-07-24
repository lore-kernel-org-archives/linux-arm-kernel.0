From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 24 Jul 2013 13:38:23 +0900
Subject: [PATCH] ARM: dts: Add basic dts for Exynos4412-based Trats 2 board
In-Reply-To: <1371653357-1389-1-git-send-email-t.figa@samsung.com>
References: <1371653357-1389-1-git-send-email-t.figa@samsung.com>
Message-ID: <0e0d01ce8827$a155f430$e401dc90$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> This patch introduces device tree sources for Samsung Trats 2 board
> based on Exynos4412 SoC.
> 
> Currently support includes:
>  - eMMC,
>  - main PMIC (max77686),
>  - serial ports,
>  - GPIO keys,
>  - touchscreen.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/boot/dts/Makefile              |   1 +
>  arch/arm/boot/dts/exynos4412-trats2.dts | 456
> ++++++++++++++++++++++++++++++++
>  2 files changed, 457 insertions(+)
>  create mode 100644 arch/arm/boot/dts/exynos4412-trats2.dts
> 
Looks good to me, applied.

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 1357510..8cdc7cc 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -53,6 +53,7 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
>  	exynos4412-odroidx.dtb \
>  	exynos4412-smdk4412.dtb \
>  	exynos4412-origen.dtb \
> +	exynos4412-trats2.dtb \
>  	exynos5250-arndale.dtb \
>  	exynos5440-sd5v1.dtb \
>  	exynos5250-smdk5250.dtb \

BTW, I put some dtbs in wrong order :( I need to sort out...

Thanks,
Kukjin
