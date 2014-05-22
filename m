From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Thu, 22 May 2014 22:52:01 +0530
Subject: [PATCH RFC v2 6/7] PM / devfreq: exynos: Fix typo in macro
In-Reply-To: <1400779322-4410-1-git-send-email-a.kesavan@samsung.com>
References: <1400779322-4410-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1400779322-4410-7-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix PPMU_BEVTSEL macro being used in the PPMU driver.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 drivers/devfreq/exynos/exynos_ppmu.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/exynos/exynos_ppmu.h b/drivers/devfreq/exynos/exynos_ppmu.h
index 71f17ba..d5c14eb 100644
--- a/drivers/devfreq/exynos/exynos_ppmu.h
+++ b/drivers/devfreq/exynos/exynos_ppmu.h
@@ -37,7 +37,7 @@
 
 #define PPMU_BEVT0SEL		0x1000
 #define PPMU_BEVTSEL_OFFSET	0x100
-#define PPMU_BEVTSEL(x)		(PPMU_BEVT0SEL + (ch * PPMU_BEVTSEL_OFFSET))
+#define PPMU_BEVTSEL(ch)	(PPMU_BEVT0SEL + (ch * PPMU_BEVTSEL_OFFSET))
 
 /* For Event Selection */
 #define RD_DATA_COUNT		0x5
-- 
1.7.9.5
