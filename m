From: b-cousson@ti.com (Benoit Cousson)
Date: Tue, 8 Jan 2013 17:13:08 +0100
Subject: [PATCH v4 0/3] ARM/dts: omap3: Add DT support for IGEP devices
In-Reply-To: <1355923990-21240-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1355923990-21240-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <50EC4594.4060507@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On 12/19/2012 02:33 PM, Javier Martinez Canillas wrote:
> IGEP technology devices are TI OMAP3 SoC based industrial embedded
> and computer-on-module boards. This patch-set adds initial device
> tree support for these devices.
> 
> The device trees allows to boot from an MMC and are working all the
> components that already have device tree support on OMAP3 SoCs:
> 
> - MMC/SD
> - UARTs
> - GPIO LEDs
> - TWL4030 codec audio
> - pinmux/pinconf pinctrl
> 
> Some peripheral are still not working such as Flash storage and
> Ethernet but support for these will also be included once the
> OMAP GPMC device tree binding patches land on mainline.
> 
> This is a v4 of the patch-set that adds MMC mux pins setup and
> fixes a build issue due recent changes on twl4030.dtsi.
> 
> The patch-set is composed of the following patches:
> 
> [PATCH v4 1/3] ARM/dts: omap3: Add generic DT support for IGEP devices
> [PATCH v4 2/3] ARM/dts: omap3: Add support for IGEPv2 board
> [PATCH v4 3/3] ARM/dts: omap3: Add support for IGEP COM Module

I've just applied your series for 3.9 on top of 3.8-rc2 and had to update the Makefile that was different in the base you used. At the same time I updated the subjects to use "ARM: dts:" prefix to be compliant with the latest trend :-)

The patches are available here:
git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.9/dts

Regards,
Benoit
