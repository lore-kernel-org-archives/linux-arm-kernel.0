From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 10 Jan 2013 11:34:05 +0100
Subject: [PATCH] ARM: mxs: select USB_ARCH_HAS_EHCI
In-Reply-To: <20130110034805.GF2265@S2101-09.ap.freescale.net>
References: <1357742162-27982-1-git-send-email-maxime.ripard@free-electrons.com>
 <20130110034805.GF2265@S2101-09.ap.freescale.net>
Message-ID: <50EE991D.9000609@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2013 04:48, Shawn Guo wrote:
> On Wed, Jan 09, 2013 at 03:36:02PM +0100, Maxime Ripard wrote:
> I prefer to fix it with the patch below.
> 
> Shawn
> 
> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> index 4c90b51..640ae6c 100644
> --- a/drivers/usb/Kconfig
> +++ b/drivers/usb/Kconfig
> @@ -37,6 +37,7 @@ config USB_ARCH_HAS_EHCI
>         default y if ARCH_W90X900
>         default y if ARCH_AT91
>         default y if ARCH_MXC
> +       default y if ARCH_MXS
>         default y if ARCH_OMAP3
>         default y if ARCH_CNS3XXX
>         default y if ARCH_VT8500
> 
> 

Ah yes, of course.
Do you want me to send a v2 with this fix, or do you want to do it yourself?

Maxime
-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
