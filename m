From: eddie.huang@mediatek.com (Eddie Huang)
Date: Thu, 23 Jul 2015 13:49:09 +0800
Subject: [PATCH v2 0/2] Add Mediatek watchdog suspend resume and shutdown 
Message-ID: <1437630551-39650-1-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add Mediatek watchdog suspend, resume and shutdown support.
These patches are based on v4.2-rc1

Change in v2:
Use watchdog_active() to check whether watchdog been active.
Change to register suspend,resume function to dev_pm_ops

Greta Zhang (2):
  watchdog: add wdt suspend/resume support
  watchdog: add wdt shutdown callback to disable wdt if enabled

 drivers/watchdog/mtk_wdt.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

-- 
1.8.1.1.dirty
