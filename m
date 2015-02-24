From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 24 Feb 2015 13:56:53 +0900
Subject: [PATCH v2 0/2] thermal: exynos: Fix NULL pointer error and bug of
 PD_DET_EN of Exynos7
Message-ID: <1424753815-15113-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set fix the bug of PD_DET_EN bit field of Exynos7 TMU.
And the clean-up the exynos compatible table by making oneline entry.

Changes from v1:
- Rebased it on Linux 4.0-rc1
- Add acked message by Lukasz Majewski
- Drop first patch [1] because NULL poiner error don't happen.
  [1] http://www.spinics.net/lists/linux-samsung-soc/msg42424.html

Chanwoo Choi (2):
  thermal: exynos: Fix wrong control of power down detection mode for Exynos7
  thermal: exynos: Clean-up code to use oneline entry for exynos compatible table

 drivers/thermal/samsung/exynos_tmu.c | 41 +++++++++++-------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

-- 
1.8.5.5
