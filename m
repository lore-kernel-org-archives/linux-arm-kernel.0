From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 26 Jan 2013 15:36:50 +0100
Subject: [PATCH 0/5] sunxi: Add pinctrl/gpio support for A10 SoCs
Message-ID: <1359211016-24097-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset add GPIO and pinctrl support for the Allwinner A10 SoC.

It adds the pin description array in the pinctrl driver, and the needed bits
in the A10 device tree.

Thanks,
Maxime

Maxime Ripard (5):
  ARM: sunxi: Increase the number of GPIOs available
  pinctrl: sunxi: Document sun5i pins functions
  ARM: pinctrl: sunxi: Add the pinctrl pin set for Allwinner A10
  ARM: sunxi: Add the sun4i pinctrl and gpio nodes
  ARM: sunxi: Add the pin groups for UART0 and UART1 on sun4i

 arch/arm/Kconfig                 |    2 +-
 arch/arm/boot/dts/sun4i-a10.dtsi |   30 ++
 drivers/pinctrl/pinctrl-sunxi.c  |  562 +++++++++++++++++++++++++++++++++++++-
 drivers/pinctrl/pinctrl-sunxi.h  |   68 +++++
 4 files changed, 657 insertions(+), 5 deletions(-)

-- 
1.7.10.4
