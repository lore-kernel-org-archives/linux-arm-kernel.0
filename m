From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 12 May 2014 23:04:06 +0800
Subject: [PATCH v2][ 3/3] ARM: imx_v6_v7_defconfig: Enable drivers for
 i.MX51 USB Host support.
In-Reply-To: <1396886641-26985-3-git-send-email-denis@eukrea.com>
References: <1396886641-26985-1-git-send-email-denis@eukrea.com>
 <1396886641-26985-3-git-send-email-denis@eukrea.com>
Message-ID: <20140512150405.GA14728@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 07, 2014 at 06:04:01PM +0200, Denis Carikli wrote:
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
> Changelog v1->v2:
> - Rebased.
> ---
>  arch/arm/configs/imx_v6_v7_defconfig |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index ca9f59a..5129f01 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -209,8 +209,10 @@ CONFIG_USB_STORAGE=y
>  CONFIG_USB_CHIPIDEA=y
>  CONFIG_USB_CHIPIDEA_UDC=y
>  CONFIG_USB_CHIPIDEA_HOST=y
> +CONFIG_USB_OTG_FSM=y

Per discussion [1], I have to drop the patch from my tree for now.

Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/323949

>  CONFIG_NOP_USB_XCEIV=y
>  CONFIG_USB_MXS_PHY=y
> +CONFIG_USB_ULPI=y
>  CONFIG_USB_GADGET=y
>  CONFIG_USB_ETH=y
>  CONFIG_MMC=y
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
