From: yangbo.lu@nxp.com (Y.b. Lu)
Date: Tue, 15 Aug 2017 02:53:21 +0000
Subject: [PATCH] ARM: multi_v7_defconfig: make eSDHC driver built-in
In-Reply-To: <1502176674-30522-1-git-send-email-yangbo.lu@nxp.com>
References: <1502176674-30522-1-git-send-email-yangbo.lu@nxp.com>
Message-ID: <DB6PR0401MB2536D5E3E91CF7943EEA4FD0F88D0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Any comments?
Thanks a lot:)

> -----Original Message-----
> From: Yangbo Lu [mailto:yangbo.lu at nxp.com]
> Sent: Tuesday, August 08, 2017 3:18 PM
> To: linux-arm-kernel at lists.infradead.org; Russell King
> Cc: Xiaobo Xie; Y.b. Lu
> Subject: [PATCH] ARM: multi_v7_defconfig: make eSDHC driver built-in
> 
> Sometimes root file system is deployed on SD card. It's proper to always
> build eSDHC driver into kernel.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig
> b/arch/arm/configs/multi_v7_defconfig
> index 4d19c1b..d407468 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -711,7 +711,7 @@ CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_PLTFM=y
>  CONFIG_MMC_SDHCI_OF_ARASAN=y
>  CONFIG_MMC_SDHCI_OF_AT91=y
> -CONFIG_MMC_SDHCI_OF_ESDHC=m
> +CONFIG_MMC_SDHCI_OF_ESDHC=y
>  CONFIG_MMC_SDHCI_ESDHC_IMX=y
>  CONFIG_MMC_SDHCI_DOVE=y
>  CONFIG_MMC_SDHCI_TEGRA=y
> --
> 2.1.0.27.g96db324
