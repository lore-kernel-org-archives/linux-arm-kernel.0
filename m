From: balbi@ti.com (Felipe Balbi)
Date: Mon, 19 Jan 2015 15:41:48 -0600
Subject: [PATCH v2] ARM: omap2plus_defconfig: Enable OHCI & EHCI HCD
 support
In-Reply-To: <1421702916-19018-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1421702916-19018-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <20150119214148.GV20386@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 10:28:36PM +0100, Sjoerd Simons wrote:
> Enable CONFIG_USB_EHCI_HCD and CONFIG_USB_OHCI_HCD to get USB supports
> with omap2plus_defconfig.
> 
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
> Changes in v2: Enable as modules rather then builtin
> 
>  arch/arm/configs/omap2plus_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index c2c3a85..f4009a2 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -159,6 +159,8 @@ CONFIG_USB_NET_SMSC95XX=y
>  CONFIG_USB_ALI_M5632=y
>  CONFIG_USB_AN2720=y
>  CONFIG_USB_EPSON2888=y
> +CONFIG_USB_EHCI_HCD=m
> +CONFIG_USB_OHCI_HCD=m
>  CONFIG_USB_KC2190=y
>  CONFIG_LIBERTAS=m
>  CONFIG_LIBERTAS_USB=m
> -- 
> 2.1.4
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150119/fcc75b36/attachment-0001.sig>
