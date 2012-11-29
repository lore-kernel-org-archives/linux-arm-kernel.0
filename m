From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Thu, 29 Nov 2012 10:35:33 +0530
Subject: [PATCH 0/2] i2c-s3c2410: Implementation bus arbitration support
Message-ID: <1354165536-18529-1-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for i2c bus arbitration between AP(exynos),
device(EC) in i2c-s3c2410 driver.

Simon Glass (2):
  i2c-s3c2410: Leave the bus disabled unless it is in use
  i2c-s3c2410: Add bus arbitration implementation

 .../devicetree/bindings/i2c/samsung-i2c.txt        |   46 +++++
 drivers/i2c/busses/i2c-s3c2410.c                   |  204 ++++++++++++++++++--
 2 files changed, 233 insertions(+), 17 deletions(-)

-- 
1.7.9.5
