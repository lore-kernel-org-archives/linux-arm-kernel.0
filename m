From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 11 Jan 2016 17:37:12 +0100
Subject: [PATCH] ARM: mvebu: Add USB nop xceiv support in
 mvebu_v7_defconfig
In-Reply-To: <1450884722-15529-1-git-send-email-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Wed, 23 Dec 2015 16:32:02 +0100")
References: <1450884722-15529-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <87ziwcxebr.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On mer., d?c. 23 2015, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> The Armada 38x based boards use this "PHY" with their xhci usb
> controller. It would be also used for Armada 39x and Armada 375 base
> boars which also had xhci controller.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Applied to mvebu/defconfig-for-4.6

Gregory


> ---
>  arch/arm/configs/mvebu_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
> index c6729bf0a8dd..cf363abd974e 100644
> --- a/arch/arm/configs/mvebu_v7_defconfig
> +++ b/arch/arm/configs/mvebu_v7_defconfig
> @@ -109,6 +109,7 @@ CONFIG_USB_XHCI_MVEBU=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_ROOT_HUB_TT=y
>  CONFIG_USB_STORAGE=y
> +CONFIG_NOP_USB_XCEIV=y
>  CONFIG_MMC=y
>  CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_PLTFM=y
> -- 
> 2.5.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
