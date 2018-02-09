From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 9 Feb 2018 15:00:24 +0800
Subject: [PATCH 0/2] clk: meson-axg: Add AO Cloclk and Reset driver
Message-ID: <20180209070026.193879-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  This patch try to add AO clock and Reset driver in Amlogic's
Meson-AXG SoC.

  Please note this patchset actually depend on the clock regmap
conversion series [1].

[1] clk: meson: use regmap in clock controllers
 https://lkml.kernel.org/r/20180131180945.18025-1-jbrunet at baylibre.com


Yixun Lan (2):
  dt-bindings: clock: reset: Add AXG AO Clock and Reset Bindings
  clk: meson-axg: Add AO Clock and Reset controller driver

 drivers/clk/meson/Makefile             |   2 +-
 drivers/clk/meson/axg-aoclk.c          | 236 +++++++++++++++++++++++++++++++++
 drivers/clk/meson/axg-aoclk.h          |  25 ++++
 include/dt-bindings/clock/axg-aoclkc.h |  26 ++++
 include/dt-bindings/reset/axg-aoclkc.h |  20 +++
 5 files changed, 308 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/meson/axg-aoclk.c
 create mode 100644 drivers/clk/meson/axg-aoclk.h
 create mode 100644 include/dt-bindings/clock/axg-aoclkc.h
 create mode 100644 include/dt-bindings/reset/axg-aoclkc.h

-- 
2.15.1
