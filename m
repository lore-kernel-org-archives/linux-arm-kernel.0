From: jtzhou@marvell.com (Jett.Zhou)
Date: Fri, 11 Nov 2011 15:38:25 +0800
Subject: [V3 0/2] mfd 88pm860x bugfix and regmap
Message-ID: <1320997107-3233-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Seperate it into two patches, one is for bugfix on the 88pm860x 
i2c interface test bank , the other is for converting 88pm860x 
i2c interface of normal bank to use regmap API

Jett.Zhou (2):
  mfd: fix 88pm860x test bank i2c interface bug
  mfd: Convert 88pm860x to use regmap api

 drivers/mfd/88pm860x-i2c.c   |  240 +++++++++++++++++++++++-------------------
 drivers/mfd/Kconfig          |    1 +
 include/linux/mfd/88pm860x.h |    3 +-
 3 files changed, 136 insertions(+), 108 deletions(-)
