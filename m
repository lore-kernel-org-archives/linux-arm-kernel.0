From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 26 May 2015 11:37:42 +0200
Subject: soc: mediatek: PMIC wrap fixes
Message-ID: <1432633064-16839-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series has two fixes for the Mediatek PMIC wrapper driver.

Sascha

----------------------------------------------------------------
Sascha Hauer (2):
      soc: mediatek: PMIC wrap: Fix clock rate handling
      soc: mediatek: PMIC wrap: Fix register state machine handling

 drivers/soc/mediatek/mtk-pmic-wrap.c | 54 ++++++------------------------------
 1 file changed, 9 insertions(+), 45 deletions(-)
