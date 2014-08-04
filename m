From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Mon,  4 Aug 2014 11:46:45 +0800
Subject: [PATCH 0/2] i2c: hix5hd2: add i2c controller driver
Message-ID: <1407124007-27631-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Wei Yan (2):
  i2c: hix5hd2: add devicetree documentation
  i2c: hix5hd2: add i2c controller driver

 .../devicetree/bindings/i2c/i2c-hix5hd2.txt        |   31 ++
 drivers/i2c/busses/Kconfig                         |   16 +
 drivers/i2c/busses/Makefile                        |    1 +
 drivers/i2c/busses/i2c-hix5hd2.c                   |  577 ++++++++++++++++++++
 4 files changed, 625 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-hix5hd2.txt
 create mode 100644 drivers/i2c/busses/i2c-hix5hd2.c

-- 
1.7.9.5
