From: jian.hu@amlogic.com (Jian Hu)
Date: Mon, 9 Jul 2018 19:12:44 +0800
Subject: [PATCH 0/3] clk: meson-g12a: Add EE clock controller driver
Message-ID: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a Clock driver for the Everyting-Else part of
the Amlogic Meson-G12A SoC.

Jian Hu (3):
  dt-bindings: clk: g12a: New binding for Meson-G12A SoC
  dt-bindings: clk: meson-g12a: Add G12A EE Clock Bindings
  clk: meson-g12a: Add EE Clock controller driver

 .../bindings/clock/amlogic,gxbb-clkc.txt           |   1 +
 drivers/clk/meson/Kconfig                          |  10 +
 drivers/clk/meson/Makefile                         |   1 +
 drivers/clk/meson/g12a.c                           | 992 +++++++++++++++++++++
 drivers/clk/meson/g12a.h                           | 123 +++
 include/dt-bindings/clock/g12a-clkc.h              |  93 ++
 6 files changed, 1220 insertions(+)
 create mode 100644 drivers/clk/meson/g12a.c
 create mode 100644 drivers/clk/meson/g12a.h
 create mode 100644 include/dt-bindings/clock/g12a-clkc.h

-- 
1.9.1
