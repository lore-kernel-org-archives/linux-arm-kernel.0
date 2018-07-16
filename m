From: andrew@aj.id.au (Andrew Jeffery)
Date: Mon, 16 Jul 2018 15:08:08 +0930
Subject: [PATCH 6/7] arm: configs: Add USB gadget to Aspeed G5 defconfig
In-Reply-To: <20180629035106.27181-7-benh@kernel.crashing.org>
References: <20180629035106.27181-1-benh@kernel.crashing.org>
 <20180629035106.27181-7-benh@kernel.crashing.org>
Message-ID: <1531719488.1119218.1441836344.2211276E@webmail.messagingengine.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Jun 2018, at 13:21, Benjamin Herrenschmidt wrote:
> Now that the vhub driver is upstream and the device-trees
> updated, let's enable this by default.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  arch/arm/configs/aspeed_g5_defconfig | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/
> aspeed_g5_defconfig
> index 8c7ea033cdc2..38e9b2d43df3 100644
> --- a/arch/arm/configs/aspeed_g5_defconfig
> +++ b/arch/arm/configs/aspeed_g5_defconfig
> @@ -140,6 +140,23 @@ CONFIG_USB_DYNAMIC_MINORS=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_ROOT_HUB_TT=y
>  CONFIG_USB_EHCI_HCD_PLATFORM=y
> +CONFIG_USB_GADGET=y
> +CONFIG_U_SERIAL_CONSOLE=y
> +CONFIG_USB_ASPEED_VHUB=y
> +CONFIG_USB_CONFIGFS=y
> +CONFIG_USB_CONFIGFS_SERIAL=y
> +CONFIG_USB_CONFIGFS_ACM=y
> +CONFIG_USB_CONFIGFS_OBEX=y
> +CONFIG_USB_CONFIGFS_NCM=y
> +CONFIG_USB_CONFIGFS_ECM=y
> +CONFIG_USB_CONFIGFS_ECM_SUBSET=y
> +CONFIG_USB_CONFIGFS_RNDIS=y
> +CONFIG_USB_CONFIGFS_EEM=y
> +CONFIG_USB_CONFIGFS_MASS_STORAGE=y
> +CONFIG_USB_CONFIGFS_F_LB_SS=y
> +CONFIG_USB_CONFIGFS_F_FS=y
> +CONFIG_USB_CONFIGFS_F_HID=y
> +CONFIG_USB_CONFIGFS_F_PRINTER=y
>  CONFIG_NEW_LEDS=y
>  CONFIG_LEDS_CLASS=y
>  CONFIG_LEDS_CLASS_FLASH=y
> -- 
> 2.17.1
> 
