From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 28 Jun 2018 14:05:15 +0200
Subject: [PATCH 1/2] ARM: mvebu_v7_defconfig: sync defconfig
In-Reply-To: <ee69693c87cd0146f259042fc5dcd29338fcdf25.1530169575.git.baruch@tkos.co.il>
 (Baruch Siach's message of "Thu, 28 Jun 2018 10:06:14 +0300")
References: <ee69693c87cd0146f259042fc5dcd29338fcdf25.1530169575.git.baruch@tkos.co.il>
Message-ID: <87k1qj6rr8.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,
 
 On jeu., juin 28 2018, Baruch Siach <baruch@tkos.co.il> wrote:

> Use savedefconfig to sync defconfig for current kernel. No change in
> generated configuration.
>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Applied on mvebu/arm

Thanks,

Gregory

> ---
>  arch/arm/configs/mvebu_v7_defconfig | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
> index ddaeda4f2e82..1ff371ae688d 100644
> --- a/arch/arm/configs/mvebu_v7_defconfig
> +++ b/arch/arm/configs/mvebu_v7_defconfig
> @@ -1,5 +1,4 @@
>  CONFIG_SYSVIPC=y
> -CONFIG_FHANDLE=y
>  CONFIG_HIGH_RES_TIMERS=y
>  CONFIG_LOG_BUF_SHIFT=14
>  CONFIG_BLK_DEV_INITRD=y
> @@ -16,10 +15,8 @@ CONFIG_MACH_ARMADA_39X=y
>  CONFIG_MACH_ARMADA_XP=y
>  CONFIG_MACH_DOVE=y
>  CONFIG_PCI=y
> -CONFIG_PCI_MSI=y
>  CONFIG_PCI_MVEBU=y
>  CONFIG_SMP=y
> -CONFIG_AEABI=y
>  CONFIG_HIGHMEM=y
>  # CONFIG_COMPACTION is not set
>  CONFIG_ZBOOT_ROM_TEXT=0x0
> @@ -58,7 +55,6 @@ CONFIG_MTD_M25P80=y
>  CONFIG_MTD_NAND=y
>  CONFIG_MTD_NAND_MARVELL=y
>  CONFIG_MTD_SPI_NOR=y
> -CONFIG_SRAM=y
>  CONFIG_MTD_UBI=y
>  CONFIG_EEPROM_AT24=y
>  CONFIG_BLK_DEV_SD=y
> @@ -67,12 +63,10 @@ CONFIG_SATA_AHCI=y
>  CONFIG_AHCI_MVEBU=y
>  CONFIG_SATA_MV=y
>  CONFIG_NETDEVICES=y
> -CONFIG_NET_DSA_MV88E6XXX=y
>  CONFIG_MV643XX_ETH=y
>  CONFIG_MVNETA=y
>  CONFIG_MVPP2=y
>  CONFIG_MARVELL_PHY=y
> -CONFIG_FIXED_PHY=y
>  CONFIG_MWIFIEX=y
>  CONFIG_MWIFIEX_SDIO=y
>  CONFIG_INPUT_EVDEV=y
> @@ -88,10 +82,11 @@ CONFIG_SPI=y
>  CONFIG_SPI_ORION=y
>  CONFIG_GPIO_SYSFS=y
>  CONFIG_GPIO_PCA953X=y
> -CONFIG_POWER_SUPPLY=y
>  CONFIG_POWER_RESET=y
>  CONFIG_POWER_RESET_GPIO=y
> +CONFIG_POWER_SUPPLY=y
>  CONFIG_SENSORS_GPIO_FAN=y
> +CONFIG_SENSORS_PWM_FAN=y
>  CONFIG_THERMAL=y
>  CONFIG_ARMADA_THERMAL=y
>  CONFIG_WATCHDOG=y
> @@ -135,7 +130,6 @@ CONFIG_MV_XOR=y
>  # CONFIG_IOMMU_SUPPORT is not set
>  CONFIG_MEMORY=y
>  CONFIG_PWM=y
> -CONFIG_SENSORS_PWM_FAN=y
>  CONFIG_EXT4_FS=y
>  CONFIG_ISO9660_FS=y
>  CONFIG_JOLIET=y
> @@ -153,10 +147,8 @@ CONFIG_NLS_ISO8859_2=y
>  CONFIG_NLS_UTF8=y
>  CONFIG_PRINTK_TIME=y
>  CONFIG_DEBUG_INFO=y
> -CONFIG_DEBUG_FS=y
>  CONFIG_MAGIC_SYSRQ=y
>  # CONFIG_SCHED_DEBUG is not set
> -CONFIG_TIMER_STATS=y
>  # CONFIG_DEBUG_BUGVERBOSE is not set
>  CONFIG_DEBUG_USER=y
>  CONFIG_CRYPTO_DEV_MARVELL_CESA=y
> -- 
> 2.18.0
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
