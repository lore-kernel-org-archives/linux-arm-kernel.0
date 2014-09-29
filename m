From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 29 Sep 2014 13:17:46 +0530
Subject: [PATCH v2 1/3] clk: samsung: Spelling s/bwtween/between/
In-Reply-To: <1411976868-22209-1-git-send-email-pankaj.dubey@samsung.com>
References: <1411976868-22209-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1411976868-22209-2-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix a typo in comment section of "struct samsung_clk_provider".

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 drivers/clk/samsung/clk.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index 66ab36b..a1ece4a 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -25,7 +25,7 @@
  * struct samsung_clk_provider: information about clock provider
  * @reg_base: virtual address for the register base.
  * @clk_data: holds clock related data like clk* and number of clocks.
- * @lock: maintains exclusion bwtween callbacks for a given clock-provider.
+ * @lock: maintains exclusion between callbacks for a given clock-provider.
  */
 struct samsung_clk_provider {
 	void __iomem *reg_base;
-- 
1.7.9.5
