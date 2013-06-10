From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Mon, 10 Jun 2013 13:02:53 +0800
Subject: [PATCH v2 0/2] support hisilicon i2c 
Message-ID: <1370840576-15651-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2:
Suggested by Baruch
Support hisilicon i2c in i2c-designware-platdrv.c, and adding two optional properties

Zhangfei Gao (2):
  i2c: designware: use module_platform_driver
  i2c: designware: add two optional property tx/rx-fifo-size

 .../devicetree/bindings/i2c/i2c-designware.txt     |    7 +++++++
 drivers/i2c/busses/i2c-designware-platdrv.c        |   17 +++++------------
 2 files changed, 12 insertions(+), 12 deletions(-)

-- 
1.7.9.5
