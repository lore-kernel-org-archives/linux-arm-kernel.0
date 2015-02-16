From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 16 Feb 2015 23:20:11 +0900
Subject: [PATCH 0/3] thermal: exynos: Fix NULL pointer error and bug of
 PD_DET_EN of Exynos7
Message-ID: <1424096414-4327-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set fix NULL pointer error during kernel booting and the bug of
PD_DET_EN bit field of Exynos7 TMU. And the clean-up the exynos compatible
table by making oneline entry.

Chanwoo Choi (3):
  thermal: exynos: Fix NULL pointer exception during kernel booting
  thermal: exynos: Fix wrong control of power down detection mode for Exynos7
  thermal: exynos: Clean-up code to use oneline entry for exynos compatible table

 drivers/thermal/samsung/exynos_tmu.c | 51 ++++++++++++------------------------
 1 file changed, 17 insertions(+), 34 deletions(-)

-- 
1.8.5.5
