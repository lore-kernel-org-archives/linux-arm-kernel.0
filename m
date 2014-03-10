From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 10 Mar 2014 09:35:56 +0800
Subject: [PATCH 9/9] ARM: imx_v4_v5_defconfig: Enable drivers for
 i.MX25/i.MX35 USB Host support.
In-Reply-To: <1394211863-7569-9-git-send-email-denis@eukrea.com>
References: <1394211863-7569-1-git-send-email-denis@eukrea.com>
 <1394211863-7569-9-git-send-email-denis@eukrea.com>
Message-ID: <20140310013555.GD2727@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 07, 2014 at 06:04:23PM +0100, Denis Carikli wrote:
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  arch/arm/configs/imx_v4_v5_defconfig |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
> index f1aeb7d..f7c4fbf 100644
> --- a/arch/arm/configs/imx_v4_v5_defconfig
> +++ b/arch/arm/configs/imx_v4_v5_defconfig
> @@ -47,6 +47,7 @@ CONFIG_ZBOOT_ROM_BSS=0x0
>  CONFIG_FPE_NWFPE=y
>  CONFIG_FPE_NWFPE_XP=y
>  CONFIG_PM_DEBUG=y
> +CONFIG_PM_RUNTIME=y

Why it is needed?

>  CONFIG_NET=y
>  CONFIG_PACKET=y
>  CONFIG_UNIX=y
> @@ -80,6 +81,7 @@ CONFIG_MTD_UBI=y
>  CONFIG_EEPROM_AT24=y
>  CONFIG_EEPROM_AT25=y
>  CONFIG_ATA=y
> +CONFIG_BLK_DEV_SD=y
>  CONFIG_PATA_IMX=y
>  CONFIG_NETDEVICES=y
>  CONFIG_CS89x0=y
> @@ -153,6 +155,12 @@ CONFIG_USB_HID=m
>  CONFIG_USB=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_MXC=y
> +CONFIG_USB_STORAGE=y
> +CONFIG_USB_CHIPIDEA=y
> +CONFIG_USB_CHIPIDEA_UDC=y
> +CONFIG_USB_CHIPIDEA_HOST=y
> +CONFIG_USB_OTG_FSM=y

Why it is needed?

> +CONFIG_NOP_USB_XCEIV=y
>  CONFIG_MMC=y
>  CONFIG_MMC_UNSAFE_RESUME=y
>  CONFIG_MMC_SDHCI=y
> -- 
> 1.7.9.5
> 

-- 

Best Regards,
Peter Chen
