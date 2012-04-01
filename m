From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun,  1 Apr 2012 12:32:39 +0100
Subject: [PATCH 1/2] clk: Fix comment for end of CONFIG_COMMON_CLK section
Message-ID: <1333279960-8497-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no else block so the #endif is for the end of the section for
CONFIG_COMMON_CLK.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/clk.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/clk.h b/include/linux/clk.h
index b025272..4b27d15 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -81,7 +81,7 @@ int clk_notifier_register(struct clk *clk, struct notifier_block *nb);
 
 int clk_notifier_unregister(struct clk *clk, struct notifier_block *nb);
 
-#endif /* !CONFIG_COMMON_CLK */
+#endif /* CONFIG_COMMON_CLK */
 
 /**
  * clk_get - lookup and obtain a reference to a clock producer.
-- 
1.7.9.1
