From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 27 Apr 2016 10:10:09 +0200
Subject: [PATCH] ARM: at91/defconfig: add PDMIC driver to sama5_defconfig
In-Reply-To: <1461685088-28659-1-git-send-email-nicolas.ferre@atmel.com>
References: <1461685088-28659-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20160427081009.GE3264@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/04/2016 at 17:38:08 +0200, Nicolas Ferre wrote :
> Add Pulse Density Modulation Interface Controller (PDMIC) driver compilation
> for sama5 default configuration. Is used by sama5d2 SoC for instance.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  arch/arm/configs/sama5_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
> index f5a3966f6793..32a082888adf 100644
> --- a/arch/arm/configs/sama5_defconfig
> +++ b/arch/arm/configs/sama5_defconfig
> @@ -158,6 +158,7 @@ CONFIG_SND_SOC=y
>  CONFIG_SND_ATMEL_SOC=y
>  CONFIG_SND_ATMEL_SOC_WM8904=y
>  # CONFIG_HID_GENERIC is not set
> +CONFIG_SND_ATMEL_SOC_PDMIC=y
>  CONFIG_USB=y
>  CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
>  CONFIG_USB_EHCI_HCD=y
> -- 
> 2.1.3
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
