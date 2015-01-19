From: balbi@ti.com (Felipe Balbi)
Date: Mon, 19 Jan 2015 15:03:41 -0600
Subject: [PATCH] ARM: omap2plus_defconfig: Enable OHCI & EHCI HCD support
In-Reply-To: <1421701046-17367-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1421701046-17367-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <20150119210341.GR20386@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 09:57:26PM +0100, Sjoerd Simons wrote:
> Enable CONFIG_USB_EHCI_HCD and CONFIG_USB_OHCI_HCD to get USB supports
> with omap2plus_defconfig.
> 
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> ---
>  arch/arm/configs/omap2plus_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index c2c3a85..295af70 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -159,6 +159,8 @@ CONFIG_USB_NET_SMSC95XX=y
>  CONFIG_USB_ALI_M5632=y
>  CONFIG_USB_AN2720=y
>  CONFIG_USB_EPSON2888=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_OHCI_HCD=y

should be modules as they break PM.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150119/b32a1e52/attachment.sig>
