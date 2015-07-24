From: eddie.huang@mediatek.com (Eddie Huang)
Date: Fri, 24 Jul 2015 15:28:44 +0800
Subject: [PATCH v3 0/2] Add Mediatek watchdog suspend resume and shutdown 
Message-ID: <1437722926-54509-1-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add Mediatek watchdog suspend, resume and shutdown support.
These patches are based on v4.2-rc1

Change in v3:
Add mtk_wdt in subject line

Change in v2:
Use watchdog_active() to check whether watchdog been active.
Change to register suspend,resume function to dev_pm_ops
