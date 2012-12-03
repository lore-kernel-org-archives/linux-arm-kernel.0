From: b-cousson@ti.com (Benoit Cousson)
Date: Mon, 3 Dec 2012 11:49:34 +0100
Subject: [PATCH v2 0/3] ARM/dts: omap3: Add DT support for IGEP devices
In-Reply-To: <1354270137-31538-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1354270137-31538-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <50BC83BE.2020202@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On 11/30/2012 11:08 AM, Javier Martinez Canillas wrote:
> IGEP technology devices are TI OMAP3 SoC based industrial embedded
> and computer-on-module boards. This patch-set adds initial device
> tree support for these devices.
> 
> The device tree allows to boot from an MMC/SD and are working all
> the components that already have device tree support on OMAP3 SoCs:

That's cool to have one more board DT converted.

That series looks good to me, I just have a comment on the DT mux stuff.

Regards,
Benoit

> 
> - MMC/SD
> - UARTs
> - GPIO LEDs
> - TWL4030 codec audio
> - pinmux/pinconf pinctrl
> 
> Some peripheral are still not working such as Flash storage and
> Ethernet but support for these will also be included once the
> OMAP GPMC device tree binding patches hit mainline.
> 
> This is a v2 of the patch-set that solves issues pointed out by
> Enric Balletbo and it is composed of the following patches:
> 
> [PATCH v2 1/3] ARM/dts: omap3: Add generic DT support for IGEP devices
> [PATCH v2 2/3] ARM/dts: omap3: Add support for IGEPv2 board
> [PATCH v2 3/3] ARM/dts: omap3: Add support for IGEP COM Module
> 
> Best regards,
> Javier
> 
