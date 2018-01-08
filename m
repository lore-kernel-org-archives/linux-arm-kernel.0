From: jolly.shah@xilinx.com (Jolly Shah)
Date: Mon, 8 Jan 2018 14:16:35 -0800
Subject: [RFC PATCH 0/2] drivers: clk: Add ZynqMP clock driver support
Message-ID: <1515449797-5629-1-git-send-email-jollys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock driver for ZynqMP

Jolly Shah (2):
  drivers: clk: Add clk_get_children support
  drivers: clk: Add ZynqMP clock driver

 .../devicetree/bindings/clock/zynq_mpsoc.txt       | 163 +++++
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk.c                                  |  28 +
 drivers/clk/zynqmp/Kconfig                         |   8 +
 drivers/clk/zynqmp/Makefile                        |   3 +
 drivers/clk/zynqmp/clk-gate-zynqmp.c               | 158 +++++
 drivers/clk/zynqmp/clk-mux-zynqmp.c                | 190 ++++++
 drivers/clk/zynqmp/clkc.c                          | 707 +++++++++++++++++++++
 drivers/clk/zynqmp/divider.c                       | 239 +++++++
 drivers/clk/zynqmp/pll.c                           | 384 +++++++++++
 include/linux/clk-provider.h                       |   1 +
 include/linux/clk/zynqmp.h                         |  46 ++
 13 files changed, 1929 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/zynq_mpsoc.txt
 create mode 100644 drivers/clk/zynqmp/Kconfig
 create mode 100644 drivers/clk/zynqmp/Makefile
 create mode 100644 drivers/clk/zynqmp/clk-gate-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-mux-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clkc.c
 create mode 100644 drivers/clk/zynqmp/divider.c
 create mode 100644 drivers/clk/zynqmp/pll.c
 create mode 100644 include/linux/clk/zynqmp.h

-- 
2.7.4
