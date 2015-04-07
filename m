From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 7 Apr 2015 10:13:26 +0100
Subject: linux-next: manual merge of the arm64 tree with the arm-soc tree
In-Reply-To: <20150407114600.14a3ecc8@canb.auug.org.au>
References: <20150407114600.14a3ecc8@canb.auug.org.au>
Message-ID: <20150407091325.GA32558@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Tue, Apr 07, 2015 at 11:46:00AM +1000, Stephen Rothwell wrote:
> diff --cc arch/arm64/configs/defconfig
> index 96bba367f80c,e07896c819ef..000000000000
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@@ -31,10 -31,12 +31,14 @@@ CONFIG_MODULES=
>   CONFIG_MODULE_UNLOAD=y
>   # CONFIG_BLK_DEV_BSG is not set
>   # CONFIG_IOSCHED_DEADLINE is not set
> + CONFIG_ARCH_EXYNOS7=y
>   CONFIG_ARCH_FSL_LS2085A=y
>   CONFIG_ARCH_MEDIATEK=y
>  +CONFIG_ARCH_QCOM=y
>  +CONFIG_ARCH_SPRD=y
> + CONFIG_ARCH_SEATTLE=y
> + CONFIG_ARCH_TEGRA=y
> + CONFIG_ARCH_TEGRA_132_SOC=y
>   CONFIG_ARCH_THUNDER=y
>   CONFIG_ARCH_VEXPRESS=y
>   CONFIG_ARCH_XGENE=y
> @@@ -105,9 -104,10 +111,11 @@@ CONFIG_VIRTIO_CONSOLE=
>   # CONFIG_HW_RANDOM is not set
>   CONFIG_SPI=y
>   CONFIG_SPI_PL022=y
>  +CONFIG_PINCTRL_MSM8916=y
>   CONFIG_GPIO_PL061=y
>   CONFIG_GPIO_XGENE=y
> + CONFIG_POWER_RESET_XGENE=y
> + CONFIG_POWER_RESET_SYSCON=y
>   # CONFIG_HWMON is not set
>   CONFIG_REGULATOR=y
>   CONFIG_REGULATOR_FIXED_VOLTAGE=y
> @@@ -133,10 -133,9 +141,11 @@@ CONFIG_MMC_SPI=
>   CONFIG_RTC_CLASS=y
>   CONFIG_RTC_DRV_EFI=y
>   CONFIG_RTC_DRV_XGENE=y
> + CONFIG_VIRTIO_PCI=y
>   CONFIG_VIRTIO_BALLOON=y
>   CONFIG_VIRTIO_MMIO=y
>  +CONFIG_COMMON_CLK_QCOM=y
>  +CONFIG_MSM_GCC_8916=y
>   # CONFIG_IOMMU_SUPPORT is not set
>   CONFIG_PHY_XGENE=y
>   CONFIG_EXT2_FS=y

It looks fine. Thanks.

-- 
Catalin
