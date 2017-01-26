From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 26 Jan 2017 18:34:21 +0900
Subject: [PATCH] arm64: defconfig: enable CONFIG_MMC_SDHCI_CADENCE
In-Reply-To: <1482718493-6792-1-git-send-email-yamada.masahiro@socionext.com>
References: <1482718493-6792-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNAR8_Aom6qZyOEV7Kd2AC_UTW3yHL_-u=6ubOBGRNhyrmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,


2016-12-26 11:14 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Enable the Cadence SD/SDIO/eMMC controller.  This is used on
> Socionext UniPhier SoC family.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Can you pick up this for ASOC, please?


>
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 0888cab..23045b4 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -384,6 +384,7 @@ CONFIG_MMC_SDHCI_ACPI=y
>  CONFIG_MMC_SDHCI_PLTFM=y
>  CONFIG_MMC_SDHCI_OF_ARASAN=y
>  CONFIG_MMC_SDHCI_OF_ESDHC=y
> +CONFIG_MMC_SDHCI_CADENCE=y
>  CONFIG_MMC_SDHCI_TEGRA=y
>  CONFIG_MMC_SDHCI_MSM=y
>  CONFIG_MMC_SPI=y
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
