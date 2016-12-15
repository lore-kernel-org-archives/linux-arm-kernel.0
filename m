From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Thu, 15 Dec 2016 13:58:11 +0800
Subject: [PATCH 0/2] add clk-hi3660
Message-ID: <1481781493-6188-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Zhangfei Gao (2):
  dt-bindings: Document the hi3660 clock bindings
  clk: hi3660: Clock driver support for Hisilicon hi3660 SoC

 .../devicetree/bindings/clock/hi3660-clock.txt     |  25 +
 drivers/clk/hisilicon/Kconfig                      |   7 +
 drivers/clk/hisilicon/Makefile                     |   1 +
 drivers/clk/hisilicon/clk-hi3660.c                 | 601 +++++++++++++++++++++
 include/dt-bindings/clock/hi3660-clock.h           | 194 +++++++
 5 files changed, 828 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/hi3660-clock.txt
 create mode 100644 drivers/clk/hisilicon/clk-hi3660.c
 create mode 100644 include/dt-bindings/clock/hi3660-clock.h

-- 
2.7.4
