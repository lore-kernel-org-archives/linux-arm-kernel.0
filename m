From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 22 May 2014 16:36:50 +0100
Subject: [PATCH 8/8] ARM: update multi_v7_defconfig for STI
In-Reply-To: <1400771902-26553-9-git-send-email-peter.griffin@linaro.org>
References: <1400771902-26553-1-git-send-email-peter.griffin@linaro.org>
 <1400771902-26553-9-git-send-email-peter.griffin@linaro.org>
Message-ID: <20140522153650.GC19747@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This patch enables SDHCI STI platform driver.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index d4e8a47..48951fc 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -277,6 +277,7 @@ CONFIG_MMC_SDHCI_TEGRA=y
>  CONFIG_MMC_SDHCI_DOVE=y
>  CONFIG_MMC_SDHCI_SPEAR=y
>  CONFIG_MMC_SDHCI_BCM_KONA=y
> +CONFIG_MMC_SDHCI_ST=y
>  CONFIG_MMC_OMAP=y
>  CONFIG_MMC_OMAP_HS=y
>  CONFIG_MMC_MVSDIO=y

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
