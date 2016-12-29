From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Thu, 29 Dec 2016 10:33:23 +0800
Subject: [PATCH v2 0/2] add clk-hi3660
Message-ID: <1482978805-6981-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Address comments from Rob and Stephen.
Rebase to 4.10-rc1

Zhangfei Gao (2):
  dt-bindings: Document the hi3660 clock bindings
  clk: hisilicon: Add clock driver for hi3660 SoC

 .../devicetree/bindings/clock/hi3660-clock.txt     |  42 ++
 drivers/clk/hisilicon/Kconfig                      |   7 +
 drivers/clk/hisilicon/Makefile                     |   1 +
 drivers/clk/hisilicon/clk-hi3660.c                 | 592 +++++++++++++++++++++
 include/dt-bindings/clock/hi3660-clock.h           | 194 +++++++
 5 files changed, 836 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/hi3660-clock.txt
 create mode 100644 drivers/clk/hisilicon/clk-hi3660.c
 create mode 100644 include/dt-bindings/clock/hi3660-clock.h

-- 
2.7.4
