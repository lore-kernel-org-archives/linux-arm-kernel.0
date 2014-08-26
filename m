From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Tue, 26 Aug 2014 13:25:19 +0800
Subject: [PATCH resend 0/2] i2c: hix5hd2: add i2c controller driver
Message-ID: <1409030722-30709-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resend: verified on 3.17-rc1

Wei Yan (2):
  i2c: hix5hd2: add devicetree documentation
  i2c: hix5hd2: add i2c controller driver

 .../devicetree/bindings/i2c/i2c-hix5hd2.txt        |   31 ++
 drivers/i2c/busses/Kconfig                         |   16 +
 drivers/i2c/busses/Makefile                        |    1 +
 drivers/i2c/busses/i2c-hix5hd2.c                   |  576 ++++++++++++++++++++
 4 files changed, 624 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-hix5hd2.txt
 create mode 100644 drivers/i2c/busses/i2c-hix5hd2.c

-- 
1.7.9.5
