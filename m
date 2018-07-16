From: jian.hu@amlogic.com (Jian Hu)
Date: Mon, 16 Jul 2018 14:37:18 +0800
Subject: [PATCH 0/2] clk: meson-g12a: Add EE clock controller driver
Message-ID: <1531723038-134012-1-git-send-email-jian.hu@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a Clock driver for the Everyting-Else part of
the Amlogic Meson-G12A SoC.

Jian Hu (2):
  dt-bindings: clk: meson-g12a: Add G12A EE Clock Bindings
  clk: meson-g12a: Add EE Clock controller driver

 .../bindings/clock/amlogic,gxbb-clkc.txt           |   1 +
 drivers/clk/meson/Kconfig                          |  10 +
 drivers/clk/meson/Makefile                         |   1 +
 drivers/clk/meson/g12a.c                           | 994 +++++++++++++++++++++
 drivers/clk/meson/g12a.h                           | 122 +++
 include/dt-bindings/clock/g12a-clkc.h              |  92 ++
 6 files changed, 1220 insertions(+)
 create mode 100644 drivers/clk/meson/g12a.c
 create mode 100644 drivers/clk/meson/g12a.h
 create mode 100644 include/dt-bindings/clock/g12a-clkc.h

-- 
1.9.1
