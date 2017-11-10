From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 10 Nov 2017 16:46:43 +0800
Subject: [PATCH 0/3] add Reset controller driver for Meson-AXG
Message-ID: <20171110084643.30980-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches add the Reset controller driver which found at
the Amlogic Meson-AXG SoC.

Yixun Lan (3):
  dt-bindings: reset: Add bindings for the Meson-AXG SoC Reset
    Controller
  reset: meson-axg: add compatible string for Meson-AXG SoC
  arm64: dts: meson-axg: add new reset DT node

 .../bindings/reset/amlogic,meson-reset.txt         |   3 +-
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi         |   6 +
 drivers/reset/reset-meson.c                        |   2 +
 .../dt-bindings/reset/amlogic,meson-axg-reset.h    | 124 +++++++++++++++++++++
 4 files changed, 134 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/reset/amlogic,meson-axg-reset.h

-- 
2.14.1
