From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun,  1 May 2016 19:36:56 +0900
Subject: [PATCH 0/7] reset: add managned reset_controller_register()
Message-ID: <1462099023-11819-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Masahiro Yamada (7):
  reset: add devm_reset_controller_register API
  reset: ath79: use devm_reset_controller_register()
  reset: lpc18xx: use devm_reset_controller_register()
  reset: pistachio: use devm_reset_controller_register()
  reset: sunxi: use devm_reset_controller_register()
  reset: socfpga: use devm_reset_controller_register()
  reset: zynq: use devm_reset_controller_register()

 Documentation/driver-model/devres.txt |  4 ++++
 drivers/reset/core.c                  | 37 +++++++++++++++++++++++++++++++++++
 drivers/reset/reset-ath79.c           |  3 +--
 drivers/reset/reset-lpc18xx.c         |  4 +---
 drivers/reset/reset-pistachio.c       | 12 +-----------
 drivers/reset/reset-socfpga.c         | 12 +-----------
 drivers/reset/reset-sunxi.c           | 12 +-----------
 drivers/reset/reset-zynq.c            | 12 +-----------
 include/linux/reset-controller.h      |  4 ++++
 9 files changed, 51 insertions(+), 49 deletions(-)

-- 
1.9.1
