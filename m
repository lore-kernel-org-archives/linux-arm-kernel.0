From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Fri, 29 Jun 2018 17:22:11 +0900
Subject: [PATCH 0/2]  regulator: add new UniPhier regulator support
Message-ID: <1530260533-19415-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add new regulator controller support for UniPhier SoCs.
Currently this supports USB3 VBUS controller only.
This USB3 VBUS is included in USB3 glue layer.

Kunihiko Hayashi (2):
  dt-bindings: regulator: add DT bindings for UniPhier regulator
  regulator: uniphier: add regulator driver for UniPhier SoC

 .../bindings/regulator/uniphier-regulator.txt      |  54 +++++
 drivers/regulator/Kconfig                          |   8 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/uniphier-regulator.c             | 251 +++++++++++++++++++++
 4 files changed, 314 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/uniphier-regulator.txt
 create mode 100644 drivers/regulator/uniphier-regulator.c

-- 
2.7.4
