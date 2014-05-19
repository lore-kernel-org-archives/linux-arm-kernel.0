From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Mon, 19 May 2014 20:57:04 +0800
Subject: [PATCH 0/3] add hix5hd2 mac driver
Message-ID: <1400504227-12047-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Zhangfei Gao (3):
  hix5hd2-clock: add complex clk
  Documentation: add Device tree bindings for Hisilicon hix5hd2
    ethernet
  net: hisilicon: add hix5hd2 mac driver

 .../bindings/net/hisilicon-hix5hd2-net.txt         |   37 +
 drivers/clk/hisilicon/clk-hix5hd2.c                |  182 ++++
 drivers/net/ethernet/Kconfig                       |    1 +
 drivers/net/ethernet/Makefile                      |    1 +
 drivers/net/ethernet/hisilicon/Kconfig             |   27 +
 drivers/net/ethernet/hisilicon/Makefile            |    5 +
 drivers/net/ethernet/hisilicon/hix5hd2.c           | 1078 ++++++++++++++++++++
 include/dt-bindings/clock/hix5hd2-clock.h          |    9 +
 8 files changed, 1340 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/hisilicon-hix5hd2-net.txt
 create mode 100644 drivers/net/ethernet/hisilicon/Kconfig
 create mode 100644 drivers/net/ethernet/hisilicon/Makefile
 create mode 100644 drivers/net/ethernet/hisilicon/hix5hd2.c

-- 
1.7.9.5
