From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 18 Oct 2016 18:01:44 -0300
Subject: [PATCH 0/4] i2c: Fix module autoload for some i2c busses platform
 drivers
Message-ID: <1476824508-4679-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wolfram,

I noticed that module autoload won't be working in some of the i2c
busses drivers. This patch series contains the fixes for these.

Best regards,
Javier


Javier Martinez Canillas (4):
  i2c: jz4780: Fix module autoload
  i2c: xlp9xx: Fix module autoload
  i2c: xlr: Fix module autoload for OF registration
  i2c: digicolor: Fix module autoload

 drivers/i2c/busses/i2c-digicolor.c | 1 +
 drivers/i2c/busses/i2c-jz4780.c    | 1 +
 drivers/i2c/busses/i2c-xlp9xx.c    | 1 +
 drivers/i2c/busses/i2c-xlr.c       | 1 +
 4 files changed, 4 insertions(+)

-- 
2.7.4
