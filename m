From: eddie.huang@mediatek.com (Eddie Huang)
Date: Wed, 22 Jul 2015 11:26:48 +0800
Subject: [PATCH 0/2] Add Mediatek watchdog suspend resume and shutdown 
Message-ID: <1437535610-51314-1-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add Mediatek watchdog suspend, resume and shutdown support.
These patches are based on v4.2-rc1

Greta Zhang (2):
  watchdog: add wdt suspend/resume support
  watchdog: add wdt shutdown callback to disable wdt if enabled

 drivers/watchdog/mtk_wdt.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

-- 
1.8.1.1.dirty
