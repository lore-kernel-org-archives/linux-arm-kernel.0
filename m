From: balbi@ti.com (Felipe Balbi)
Date: Tue, 1 Apr 2014 09:11:35 -0500
Subject: [PATCH] ARM: OMAP2+: Fix config name for USB3 PHY
In-Reply-To: <1396347274-32750-1-git-send-email-kishon@ti.com>
References: <1396347274-32750-1-git-send-email-kishon@ti.com>
Message-ID: <20140401141135.GA4717@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 01, 2014 at 03:44:34PM +0530, Kishon Vijay Abraham I wrote:
> commit a70143 (drivers: phy: usb3/pipe3: Adapt pipe3 driver to Generic PHY
> Framework) moved phy-omap-usb3 driver in drivers/usb/phy to drivers/phy and
> also renamed the file to phy-ti-pipe3. It also renamed the config from
> OMAP_USB3 to TI_PIPE3 in Kconfig. However the config name was not changed in
> omap2plus_defconfig. Fixed it here.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/configs/omap2plus_defconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index a966795..a4e8d01 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -226,7 +226,7 @@ CONFIG_USB_DWC3=m
>  CONFIG_USB_TEST=y
>  CONFIG_NOP_USB_XCEIV=y
>  CONFIG_OMAP_USB2=y
> -CONFIG_OMAP_USB3=y
> +CONFIG_TI_PIPE3=y
>  CONFIG_AM335X_PHY_USB=y
>  CONFIG_USB_GADGET=y
>  CONFIG_USB_GADGET_DEBUG=y
> -- 
> 1.7.9.5
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140401/bcc7f4cf/attachment-0001.sig>
