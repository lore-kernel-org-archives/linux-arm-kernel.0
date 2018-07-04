From: yixun.lan@amlogic.com (Yixun Lan)
Date: Wed, 4 Jul 2018 22:45:08 +0000
Subject: [PATCH 0/3] pinctrl: meson-g12a: add pinctrl driver support
Message-ID: <20180704224511.29350-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series try to add pinctrl driver support for
the Meson-G12A SoC.


Yixun Lan (3):
  documentation: Add compatibles for Amlogic Meson G12A pin controllers
  dt-bindings: pinctrl: meson-g12a: document pin name
  pinctrl: meson-g12a: add pinctrl driver support

 .../bindings/pinctrl/meson,pinctrl.txt        |    2 +
 drivers/pinctrl/meson/Kconfig                 |    6 +
 drivers/pinctrl/meson/Makefile                |    1 +
 drivers/pinctrl/meson/pinctrl-meson-g12a.c    | 1432 +++++++++++++++++
 include/dt-bindings/gpio/meson-g12a-gpio.h    |  114 ++
 5 files changed, 1555 insertions(+)
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson-g12a.c
 create mode 100644 include/dt-bindings/gpio/meson-g12a-gpio.h

-- 
2.18.0
