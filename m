From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Sun, 28 Sep 2014 12:22:06 +0800
Subject: [PATCH v2 0/3] i2c: hix5hd2: add i2c controller driver
Message-ID: <1411878129-19743-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2: 
Modify according to Wolfram's comments 
including change vector name, coding style, return value etc.

Wei Yan (2):
  i2c: hix5hd2: add devicetree documentation
  i2c: hix5hd2: add i2c controller driver

Zhangfei Gao (1):
  ARM: dts: hix5hd2: add i2c node

 .../devicetree/bindings/i2c/i2c-hix5hd2.txt        |   31 ++
 arch/arm/boot/dts/hisi-x5hd2.dtsi                  |   60 +++
 drivers/i2c/busses/Kconfig                         |   10 +
 drivers/i2c/busses/Makefile                        |    1 +
 drivers/i2c/busses/i2c-hix5hd2.c                   |  555 ++++++++++++++++++++
 5 files changed, 657 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-hix5hd2.txt
 create mode 100644 drivers/i2c/busses/i2c-hix5hd2.c

-- 
1.7.9.5
