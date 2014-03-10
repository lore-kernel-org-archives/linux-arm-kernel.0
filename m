From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 10 Mar 2014 09:36:29 +0800
Subject: [PATCH 8/9] ARM: imx_v6_v7_defconfig: Enable drivers for
 i.MX51 USB Host support.
In-Reply-To: <1394211863-7569-8-git-send-email-denis@eukrea.com>
References: <1394211863-7569-1-git-send-email-denis@eukrea.com>
 <1394211863-7569-8-git-send-email-denis@eukrea.com>
Message-ID: <20140310013627.GE2727@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 07, 2014 at 06:04:22PM +0100, Denis Carikli wrote:
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  arch/arm/configs/imx_v6_v7_defconfig |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index 09e9743..772f14f 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -209,8 +209,10 @@ CONFIG_USB_STORAGE=y
>  CONFIG_USB_CHIPIDEA=y
>  CONFIG_USB_CHIPIDEA_UDC=y
>  CONFIG_USB_CHIPIDEA_HOST=y
> +CONFIG_USB_OTG_FSM=y

Why it is needed?

>  CONFIG_NOP_USB_XCEIV=y
>  CONFIG_USB_MXS_PHY=y
> +CONFIG_USB_ULPI=y
>  CONFIG_USB_GADGET=y
>  CONFIG_USB_ETH=m
>  CONFIG_USB_MASS_STORAGE=m
> -- 
> 1.7.9.5
> 
> 
> 

-- 

Best Regards,
Peter Chen
