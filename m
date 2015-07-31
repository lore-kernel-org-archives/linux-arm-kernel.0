From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Jul 2015 19:01:37 +0200
Subject: [PATCH v2 2/2] ARM: multi_v7_defconfig: Enable Allwinner P2WI,
 PWM, DMA_SUN6I, cryptodev
In-Reply-To: <1438354602-6361-3-git-send-email-wens@csie.org>
References: <1438354602-6361-1-git-send-email-wens@csie.org>
 <1438354602-6361-3-git-send-email-wens@csie.org>
Message-ID: <20150731170137.GN2564@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 10:56:42PM +0800, Chen-Yu Tsai wrote:
> Enable drivers for Allwinner P2WI, PWM, cryptodev (Security System) and
> sun6i DMA engine. Also enable EXTCON as PHY_SUN4I_USB depends on it.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/configs/multi_v7_defconfig | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 5fd8df6f50ea..5eaf39ce134e 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -301,6 +301,7 @@ CONFIG_I2C_S3C2410=y
>  CONFIG_I2C_SH_MOBILE=y
>  CONFIG_I2C_SIRF=y
>  CONFIG_I2C_ST=y
> +CONFIG_I2C_SUN6I_P2WI=y
>  CONFIG_I2C_TEGRA=y
>  CONFIG_I2C_XILINX=y
>  CONFIG_I2C_RCAR=y
> @@ -587,6 +588,7 @@ CONFIG_IMX_DMA=y
>  CONFIG_MXS_DMA=y
>  CONFIG_DMA_OMAP=y
>  CONFIG_XILINX_VDMA=y
> +CONFIG_DMA_SUN6I=y
>  CONFIG_STAGING=y
>  CONFIG_SENSORS_ISL29018=y
>  CONFIG_SENSORS_ISL29028=y
> @@ -612,6 +614,7 @@ CONFIG_TEGRA_IOMMU_SMMU=y
>  CONFIG_PM_DEVFREQ=y
>  CONFIG_ARM_TEGRA_DEVFREQ=m
>  CONFIG_MEMORY=y
> +CONFIG_EXTCON=y
>  CONFIG_TI_AEMIF=y
>  CONFIG_IIO=y
>  CONFIG_AT91_ADC=m
> @@ -622,6 +625,7 @@ CONFIG_PWM_ATMEL=m
>  CONFIG_PWM_ATMEL_TCB=m
>  CONFIG_PWM_RENESAS_TPU=y
>  CONFIG_PWM_SAMSUNG=m
> +CONFIG_PWM_SUN4I=y
>  CONFIG_PWM_TEGRA=y
>  CONFIG_PWM_VT8500=y
>  CONFIG_PHY_HIX5HD2_SATA=y
> @@ -660,6 +664,7 @@ CONFIG_LOCKUP_DETECTOR=y
>  CONFIG_CRYPTO_DEV_TEGRA_AES=y
>  CONFIG_CPUFREQ_DT=y
>  CONFIG_KEYSTONE_IRQ=y
> +CONFIG_CRYPTO_DEV_SUN4I_SS=m

Why do you enable it as a module?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150731/23677303/attachment.sig>
