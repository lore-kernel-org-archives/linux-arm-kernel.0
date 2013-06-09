From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Sun,  9 Jun 2013 10:36:40 +0800
Subject: [PATCH 0/2] support i2c-designware-hs
Message-ID: <1370745402-11844-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support i2c-designware-hs.c, based on designware i2c ip 

Zhangfei Gao (2):
  i2c-designware: support no DW_IC_COMP_TYPE platform
  i2c: designware: Add i2c-designware-hs

 .../devicetree/bindings/i2c/i2c-designware-hs.txt  |   30 +++
 drivers/i2c/busses/Kconfig                         |   10 +
 drivers/i2c/busses/Makefile                        |    1 +
 drivers/i2c/busses/i2c-designware-core.c           |   24 +--
 drivers/i2c/busses/i2c-designware-core.h           |    1 +
 drivers/i2c/busses/i2c-designware-hs.c             |  194 ++++++++++++++++++++
 6 files changed, 249 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-designware-hs.txt
 create mode 100644 drivers/i2c/busses/i2c-designware-hs.c

-- 
1.7.9.5
