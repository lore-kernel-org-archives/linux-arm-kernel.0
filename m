From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 28 Jan 2013 21:22:29 -0800
Subject: [PATCH 1/2] arm: exynos5: Enable PM generic domain support in
 Kconfig
In-Reply-To: <1357733733-18769-2-git-send-email-prasanna.ps@samsung.com>
References: <1357733733-18769-1-git-send-email-prasanna.ps@samsung.com>
 <1357733733-18769-2-git-send-email-prasanna.ps@samsung.com>
Message-ID: <05b901cdfde0$a373a860$ea5af920$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prasanna Kumar wrote:
> 
> This patch adds support to enable PM generic domains
> under Exynos5 family
> 
> Signed-off-by: Prasanna Kumar <prasanna.ps@samsung.com>
> ---
>  arch/arm/mach-exynos/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-
> exynos/Kconfig
> index e103c29..871be97 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -63,6 +63,7 @@ config SOC_EXYNOS5250
>  	depends on ARCH_EXYNOS5
>  	select S5P_PM if PM
>  	select S5P_SLEEP if PM
> +	select PM_GENERIC_DOMAINS if PM
>  	select S5P_DEV_MFC
>  	select SAMSUNG_DMADEV
>  	help
> --
> 1.7.5.4

Firstly, this patch can be squashed into 2nd one.
Secondly, please put the statements alphanumerically.
Finally, please use the same format for subject like following:
"ARM: EXYNOS: ..."

Thanks.

- Kukjin
