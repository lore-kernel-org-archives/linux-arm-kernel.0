From: zhongkaihua@huawei.com (Kaihua Zhong)
Date: Fri, 3 Nov 2017 15:25:04 +0800
Subject: [PATCH 0/3] Hi3660 stubclock drivers 
Message-ID: <1509693907-90682-1-git-send-email-zhongkaihua@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset relies on Hi3660 mailbox drivers.

Kaihua Zhong (2):
  clk: hisilicon: Add support for Hi3660 stub clocks
  arm64: dts: Hi3660: Add binding for stub clock

Leo Yan (1):
  dt-bindings: clk: Hi3660: Document stub clock

 .../devicetree/bindings/clock/hi3660-clock.txt     |   6 +
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |   8 +
 drivers/clk/hisilicon/Kconfig                      |   6 +
 drivers/clk/hisilicon/Makefile                     |   1 +
 drivers/clk/hisilicon/clk-hi3660-stub.c            | 195 +++++++++++++++++++++
 include/dt-bindings/clock/hi3660-clock.h           |   7 +
 6 files changed, 223 insertions(+)
 create mode 100644 drivers/clk/hisilicon/clk-hi3660-stub.c

-- 
1.9.1
