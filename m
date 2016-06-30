From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Thu, 30 Jun 2016 10:00:57 +0800
Subject: fix some host driver defect
Message-ID: <1467252061-3791-1-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Chaotian Jing (4):
  mmc: mediatek: do not tune data for HS400 mode
  mmc: mediatek: fix CRC error when calling mmc_select_hs400()
  mmc: mediatek: fix CMD21/CMD19 timeout issue
  mmc: mediatek: perfer to use rise edge latching

 drivers/mmc/host/mtk-sd.c | 70 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 14 deletions(-)

-- 
1.8.1.1.dirty
