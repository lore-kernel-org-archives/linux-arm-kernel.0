From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 26 Dec 2013 09:08:34 -0300
Subject: [PATCH] ARM: configs: Select USB PHY for AM335x SoC
In-Reply-To: <1386861269-28949-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1386861269-28949-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131226120833.GA24645@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe,

On Thu, Dec 12, 2013 at 12:14:29PM -0300, Ezequiel Garcia wrote:
> Enable this option as it's required to use USB on AM335x SoC.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/configs/omap2plus_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index 12c848e..e427b95 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -223,6 +223,7 @@ CONFIG_USB_TEST=y
>  CONFIG_NOP_USB_XCEIV=y
>  CONFIG_OMAP_USB2=y
>  CONFIG_OMAP_USB3=y
> +CONFIG_AM335X_PHY_USB=y
>  CONFIG_USB_GADGET=y
>  CONFIG_USB_GADGET_DEBUG=y
>  CONFIG_USB_GADGET_DEBUG_FILES=y
> -- 
> 1.8.1.5
> 

Maybe you can take this through your tree?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
