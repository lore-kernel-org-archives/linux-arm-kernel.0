From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  4 Jan 2013 17:45:07 +0100
Subject: [PATCH 0/2] Add GPIO driver for Allwinner SoCs
Message-ID: <1357317909-12458-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch adds support for the GPIOs for the Allwinner SoCs supported so
far.

It comes on top of my previous pinctrl patchset, and has been tested on a
A13-Olinuxino from Olimex.

Thanks,
Maxime

Maxime Ripard (2):
  ARM: sunxi: gpio: Add Allwinner SoCs GPIO drivers
  ARM: sunxi: Add the GPIOs node to the device tree

 .../devicetree/bindings/gpio/gpio-sunxi.txt        |   77 ++++++++++
 arch/arm/boot/dts/sun5i-a13.dtsi                   |   51 +++++++
 drivers/gpio/Kconfig                               |    6 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-sunxi.c                          |  150 ++++++++++++++++++++
 drivers/pinctrl/pinctrl-sunxi.c                    |  106 ++++++++++++++
 drivers/pinctrl/pinctrl-sunxi.h                    |    6 +-
 7 files changed, 396 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-sunxi.txt
 create mode 100644 drivers/gpio/gpio-sunxi.c

-- 
1.7.10.4
