From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 30 Nov 2015 15:27:36 +0100
Subject: [PATCH 1/2] ARM: mvebu: update v5 defconfig
In-Reply-To: <1448461036-16724-1-git-send-email-linus.walleij@linaro.org>
 (Linus Walleij's message of "Wed, 25 Nov 2015 15:17:16 +0100")
References: <1448461036-16724-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <87610j5zqf.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,
 
 On mer., nov. 25 2015, Linus Walleij <linus.walleij@linaro.org> wrote:

> This just regenerates the v5 mvebu defconfig with the latest
> defaults so as to avoid too much fuzz when applying patches to
> it.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied on mvebu/defconfig

with Andrew's Acked-by

Thanks,

Gregory

> ---
>  arch/arm/configs/mvebu_v5_defconfig | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
> index 824de499237b..519c72725798 100644
> --- a/arch/arm/configs/mvebu_v5_defconfig
> +++ b/arch/arm/configs/mvebu_v5_defconfig
> @@ -12,7 +12,6 @@ CONFIG_MODULE_UNLOAD=y
>  # CONFIG_ARCH_MULTI_V7 is not set
>  CONFIG_ARCH_MVEBU=y
>  CONFIG_MACH_KIRKWOOD=y
> -CONFIG_MACH_NETXBIG=y
>  # CONFIG_CPU_FEROCEON_OLD_ID is not set
>  CONFIG_PCI_MVEBU=y
>  CONFIG_PREEMPT=y
> @@ -66,8 +65,6 @@ CONFIG_ATA=y
>  CONFIG_SATA_AHCI=y
>  CONFIG_SATA_MV=y
>  CONFIG_NETDEVICES=y
> -CONFIG_NET_DSA_MV88E6123_61_65=y
> -CONFIG_NET_DSA_MV88E6171=y
>  CONFIG_MV643XX_ETH=y
>  CONFIG_R8169=y
>  CONFIG_MARVELL_PHY=y
> @@ -91,7 +88,6 @@ CONFIG_I2C_MV64XXX=y
>  CONFIG_SPI=y
>  CONFIG_SPI_ORION=y
>  CONFIG_GPIO_SYSFS=y
> -CONFIG_POWER_SUPPLY=y
>  CONFIG_POWER_RESET=y
>  CONFIG_POWER_RESET_GPIO=y
>  CONFIG_POWER_RESET_QNAP=y
> @@ -103,16 +99,15 @@ CONFIG_SENSORS_LM85=y
>  CONFIG_THERMAL=y
>  CONFIG_WATCHDOG=y
>  CONFIG_ORION_WATCHDOG=y
> +CONFIG_REGULATOR=y
> +CONFIG_REGULATOR_FIXED_VOLTAGE=y
>  CONFIG_FB=y
>  CONFIG_SOUND=y
>  CONFIG_SND=y
>  CONFIG_SND_SOC=y
>  CONFIG_SND_KIRKWOOD_SOC=y
> -CONFIG_SND_KIRKWOOD_SOC_T5325=y
>  CONFIG_SND_SOC_ALC5623=y
>  CONFIG_SND_SIMPLE_CARD=y
> -CONFIG_REGULATOR=y
> -CONFIG_REGULATOR_FIXED_VOLTAGE=y
>  CONFIG_HID_DRAGONRISE=y
>  CONFIG_HID_GYRATION=y
>  CONFIG_HID_TWINHAN=y
> @@ -159,8 +154,6 @@ CONFIG_STAGING=y
>  CONFIG_FB_XGI=y
>  CONFIG_EXT2_FS=y
>  CONFIG_EXT3_FS=y
> -# CONFIG_EXT3_FS_XATTR is not set
> -CONFIG_EXT4_FS=y
>  CONFIG_ISO9660_FS=m
>  CONFIG_JOLIET=y
>  CONFIG_UDF_FS=m
> @@ -186,7 +179,6 @@ CONFIG_DEBUG_KERNEL=y
>  CONFIG_DEBUG_USER=y
>  CONFIG_CRYPTO_CBC=m
>  CONFIG_CRYPTO_PCBC=m
> -# CONFIG_CRYPTO_ANSI_CPRNG is not set
>  CONFIG_CRYPTO_DEV_MV_CESA=y
>  CONFIG_CRC_CCITT=y
>  CONFIG_LIBCRC32C=y
> -- 
> 2.4.3
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
