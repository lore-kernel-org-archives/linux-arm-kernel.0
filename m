From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 29 Aug 2013 19:36:40 -0400
Subject: [PATCH v2 0/4] ARM: keystone: clock tree and PM bus support
Message-ID: <1377819404-9671-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Refreshed version of the ealier patch series against the updated
clock dt bidnings series[1] and [2]

Tested on Keystone EVM with [1] [2] integrated.

Cc: Mike Turquette <mturquette@linaro.org>
Cc: arm at kernel.org

Santosh Shilimkar (4):
  ARM: dts: keystone: Add clock tree data to devicetree
  ARM: dts: keystone: Add clock phandle to UART nodes
  ARM: keystone: Enable clock drivers
  ARM: keystone: add PM bus support for clock management

 arch/arm/boot/dts/keystone-clocks.dtsi |  821 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/keystone.dts         |    4 +
 arch/arm/mach-keystone/Kconfig         |    1 +
 drivers/bus/Makefile                   |    2 +
 drivers/bus/keystone_pm_bus.c          |   70 +++
 5 files changed, 898 insertions(+)
 create mode 100644 arch/arm/boot/dts/keystone-clocks.dtsi
 create mode 100644 drivers/bus/keystone_pm_bus.c

Regards,
Santosh

[1] http://lkml.org/lkml/2013/8/22/52 
[2] http://www.spinics.net/lists/arm-kernel/msg270884.html
-- 
1.7.9.5
