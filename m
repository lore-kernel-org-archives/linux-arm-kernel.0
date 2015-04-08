From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed,  8 Apr 2015 10:50:16 +0200
Subject: [PATCH] soc/mediatek: Remove unused variables
Message-ID: <1428483016-5472-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The PMIC wrapper driver adds a couple of variables that are never used.
Remove them to avoid build warnings.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 4a38506154c6..db5be1eec54c 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -563,8 +563,6 @@ static int pwrap_init_sidly(struct pmic_wrapper *wrp)
 
 static int pwrap_init_reg_clock(struct pmic_wrapper *wrp)
 {
-	u32 wdata;
-	u32 rdata;
 	unsigned long rate_spi;
 	int ck_mhz;
 
-- 
2.3.2
