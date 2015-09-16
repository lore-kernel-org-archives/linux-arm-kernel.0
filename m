From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 16 Sep 2015 10:28:25 +0200
Subject: [PATCH 0/6] pinctrl: Remove unneded semicolons in drivers
Message-ID: <1442392111-8448-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Linus,

This series contains trivial patches that removes unneeded
semicolons in pinctrl drivers. These are clearly typo errors
and are just creating null statements.

Best regards,
Javier


Javier Martinez Canillas (6):
  pinctrl: tz1090: Remove unneded semicolons
  pinctrl: tz1090-pdc: Remove unneded semicolons
  pinctrl: mxs: Remove unneded semicolon
  pinctrl: sunxi: Remove unneeded semicolon
  pinctrl: mediatek: Remove unneded semicolon
  pinctrl: samsung: Remove unneded semicolon

 drivers/pinctrl/freescale/pinctrl-mxs.c       | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 2 +-
 drivers/pinctrl/pinctrl-tz1090-pdc.c          | 4 ++--
 drivers/pinctrl/pinctrl-tz1090.c              | 4 ++--
 drivers/pinctrl/samsung/pinctrl-exynos5440.c  | 2 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c         | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.4.3
