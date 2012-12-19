From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 19 Dec 2012 14:33:07 +0100
Subject: [PATCH v4 0/3] ARM/dts: omap3: Add DT support for IGEP devices
Message-ID: <1355923990-21240-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IGEP technology devices are TI OMAP3 SoC based industrial embedded
and computer-on-module boards. This patch-set adds initial device
tree support for these devices.

The device trees allows to boot from an MMC and are working all the
components that already have device tree support on OMAP3 SoCs:

- MMC/SD
- UARTs
- GPIO LEDs
- TWL4030 codec audio
- pinmux/pinconf pinctrl

Some peripheral are still not working such as Flash storage and
Ethernet but support for these will also be included once the
OMAP GPMC device tree binding patches land on mainline.

This is a v4 of the patch-set that adds MMC mux pins setup and
fixes a build issue due recent changes on twl4030.dtsi.

The patch-set is composed of the following patches:

[PATCH v4 1/3] ARM/dts: omap3: Add generic DT support for IGEP devices
[PATCH v4 2/3] ARM/dts: omap3: Add support for IGEPv2 board
[PATCH v4 3/3] ARM/dts: omap3: Add support for IGEP COM Module
