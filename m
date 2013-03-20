From: balbi@ti.com (Felipe Balbi)
Date: Wed, 20 Mar 2013 08:20:42 +0200
Subject: [PATCH 2/2] ARM: imx_v4_v5_defconfig: Select CONFIG_USB_PHY
In-Reply-To: <1363743553-17295-2-git-send-email-festevam@gmail.com>
References: <1363743553-17295-1-git-send-email-festevam@gmail.com>
 <1363743553-17295-2-git-send-email-festevam@gmail.com>
Message-ID: <20130320062042.GE25876@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 19, 2013 at 10:39:13PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Since commit edc7cb2e955f (usb: phy: make it a menuconfig) in order to be able to
> select CONFIG_USB_ULPI, it is necessary to select CONFIG_USB_PHY.  
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/configs/imx_v4_v5_defconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
> index 02c657a..d56bedc 100644
> --- a/arch/arm/configs/imx_v4_v5_defconfig
> +++ b/arch/arm/configs/imx_v4_v5_defconfig
> @@ -156,6 +156,7 @@ CONFIG_USB_HID=m
>  CONFIG_USB=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_MXC=y
> +CONFIG_USB_PHY=y
>  CONFIG_USB_ULPI=y
>  CONFIG_MMC=y
>  CONFIG_MMC_SDHCI=y
> -- 
> 1.7.9.5
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130320/538bd93a/attachment.sig>
