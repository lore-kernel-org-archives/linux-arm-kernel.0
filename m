From: narmstrong@baylibre.com (Neil Armstrong)
Date: Sun,  3 Apr 2016 15:26:07 +0200
Subject: [PATCH 0/2] pinctrl: Oxford Semiconductor OXNAS pinctrl and gpio
 support
Message-ID: <1459689969-5326-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset includes support for the pinctrl and gpio controller of the
Oxford Semiconductor OXNAS SoC Family.

It was originally posted part of a platform patchset available here :
http://lkml.kernel.org/r/1458838215-23314-1-git-send-email-narmstrong at baylibre.com

Changes this v3 patchset :
- Get rid of PLX Technology, replace by Oxford Semiconductor
- Get rid of gpio-bank and ngpios properties, now using gpio-ranges

Neil Armstrong (2):
  pinctrl: Add Oxford Semiconductor OXNAS pinctrl and gpio driver
  dt-bindings: Add Oxford Semiconductor OXNAS pinctrl and gpio bindings

 .../devicetree/bindings/gpio/gpio_oxnas.txt        |  43 ++
 .../devicetree/bindings/pinctrl/oxnas,pinctrl.txt  |  57 ++
 drivers/pinctrl/Kconfig                            |  11 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-oxnas.c                    | 837 +++++++++++++++++++++
 5 files changed, 949 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/oxnas,pinctrl.txt
 create mode 100644 drivers/pinctrl/pinctrl-oxnas.c

-- 
1.9.1
