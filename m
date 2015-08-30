From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 30 Aug 2015 09:33:52 +0200
Subject: [PATCH v4 0/4] regmap: i2c block support
Message-ID: <1440920036-17517-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Rebased the series against your for-next branch. I hope this is the right one.

Best Regards,

Markus


Markus Pargmann (4):
  regmap: Introduce max_raw_read/write for regmap_bulk_read/write
  regmap: regmap max_raw_read/write getter functions
  regmap: Add raw_write/read checks for max_raw_write/read sizes
  regmap-i2c: Add smbus i2c block support

 drivers/base/regmap/internal.h   |   4 ++
 drivers/base/regmap/regmap-i2c.c |  49 +++++++++++++++++
 drivers/base/regmap/regmap.c     | 113 +++++++++++++++++++++++++++++++++------
 include/linux/regmap.h           |   6 +++
 4 files changed, 157 insertions(+), 15 deletions(-)

-- 
2.5.0
