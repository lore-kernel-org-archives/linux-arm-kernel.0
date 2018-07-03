From: yixun.lan@amlogic.com (Yixun Lan)
Date: Tue, 3 Jul 2018 14:57:13 +0000
Subject: [PATCH 0/3] clk: meson: add a sub EMMC clock controller support
Message-ID: <20180703145716.31860-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver will add a EMMC clock controller driver support.
The original idea about adding a clock controller is during the
discussion in the NAND driver mainline effort[1].

I've tested this in the S400 board (AXG platform) by using NAND driver.

[1] https://lkml.kernel.org/r/20180628090034.0637a062 at xps13

Yixun Lan (3):
  clk: meson: add DT documentation for emmc clock controller
  clk: meson: add sub EMMC clock dt-bindings IDs
  clk: meson: add sub EMMC clock controller driver

 .../bindings/clock/amlogic,emmc-clkc.txt      |  45 ++++++
 drivers/clk/meson/Kconfig                     |   9 ++
 drivers/clk/meson/Makefile                    |   1 +
 drivers/clk/meson/emmc-clkc.c                 | 136 ++++++++++++++++++
 include/dt-bindings/clock/emmc-clkc.h         |  14 ++
 5 files changed, 205 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,emmc-clkc.txt
 create mode 100644 drivers/clk/meson/emmc-clkc.c
 create mode 100644 include/dt-bindings/clock/emmc-clkc.h

-- 
2.18.0
