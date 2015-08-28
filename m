From: balbi@ti.com (Felipe Balbi)
Date: Fri, 28 Aug 2015 15:12:28 -0500
Subject: [PATCH] ARM: omap2plus_defconfig: Enable MUSB DMA support
In-Reply-To: <1440789582-25392-1-git-send-email-tony@atomide.com>
References: <1440789582-25392-1-git-send-email-tony@atomide.com>
Message-ID: <20150828201228.GE7334@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 28, 2015 at 12:19:42PM -0700, Tony Lindgren wrote:
> With recent MUSB changes we can now build in support for multiple
> DMA implementations. So let's enable DMA by default to make life
> easier for distro use.
> 
> Cc: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/configs/omap2plus_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index 789fa5a8..1d5f80f 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -350,6 +350,8 @@ CONFIG_USB_MUSB_HDRC=m
>  CONFIG_USB_MUSB_OMAP2PLUS=m
>  CONFIG_USB_MUSB_AM35X=m
>  CONFIG_USB_MUSB_DSPS=m
> +CONFIG_USB_INVENTRA_DMA=y
> +CONFIG_USB_TI_CPPI41_DMA=y
>  CONFIG_USB_DWC3=m
>  CONFIG_USB_TEST=m
>  CONFIG_AM335X_PHY_USB=y
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150828/793f5691/attachment.sig>
