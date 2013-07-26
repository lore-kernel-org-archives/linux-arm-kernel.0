From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Fri, 26 Jul 2013 21:22:16 +0800
Subject: [PATCH v4 0/2] support hisilicon i2c 
Message-ID: <1374844938-25505-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

V4:
resend for 3.11

v3:
patch 02, use size instead of threshold

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
