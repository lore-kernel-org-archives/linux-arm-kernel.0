From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 12 Jul 2012 15:02:17 +0800
Subject: [PATCH v7 0/6] imx28/imx6q: add usb support
In-Reply-To: <1342059927-25661-1-git-send-email-richard.zhao@freescale.com>
References: <1342059927-25661-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120712070215.GI6971@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2012 at 10:25:21AM +0800, Richard Zhao wrote:
> This is platform part to add imx28/imx6q driver support.
> The dirver part has been mostly merged to usb-next.
> 
> Changes since last version:
>  - correct subject
>  - use of_find_compatible_node
>  - remove hub reset
>  - add mx28 evk gpio pinctrl 
> 
> Richard Zhao (6):
>   ARM: imx6q: add usb controller clock lookups
>   ARM: imx6q: add usbphy clocks
>   ARM: imx6q: disable usb charger detector
>   ARM: dts: imx6q-sabrelite: add usb devices
>   clk: mxs: clk_register_clkdev mx28 usb clocks
>   ARM: dts: imx28-evk: add usb devices
> 
Applied all, thanks.

Regards,
Shawn
