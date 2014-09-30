From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Tue, 30 Sep 2014 20:20:25 +0800
Subject: [PATCH v3 0/3] i2c: hix5hd2: add i2c controller driver
Message-ID: <1412079628-6316-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v3:
Add COMPILE_TEST as dependence to enable compile test
Remove specific mach info in dts binding to solve the confusion.

v2: 
Modify according to Wolfram's comments 
including change vector name, coding style, return value etc.

Wei Yan (2):
  i2c: hix5hd2: add devicetree documentation
  i2c: hix5hd2: add i2c controller driver

Zhangfei Gao (1):
  ARM: dts: hix5hd2: add i2c node

 .../devicetree/bindings/i2c/i2c-hix5hd2.txt        |   25 +
 arch/arm/boot/dts/hisi-x5hd2.dtsi                  |   60 +++
 drivers/i2c/busses/Kconfig                         |   10 +
 drivers/i2c/busses/Makefile                        |    1 +
 drivers/i2c/busses/i2c-hix5hd2.c                   |  554 ++++++++++++++++++++
 5 files changed, 650 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-hix5hd2.txt
 create mode 100644 drivers/i2c/busses/i2c-hix5hd2.c

-- 
1.7.9.5
