From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 27 Mar 2014 12:08:36 +0100
Subject: [PATCH] clk: Fix minor errors in of_clk_init() function comments
Message-ID: <1395918516-23822-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/clk/clk.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c859adf..29dc1e7 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2575,7 +2575,7 @@ static int parent_ready(struct device_node *np)
  * @matches: array of compatible values and init functions for providers.
  *
  * This function scans the device tree for matching clock providers
- * and calls their initialization functions. It also do it by trying
+ * and calls their initialization functions. It also does it by trying
  * to follow the dependencies.
  */
 void __init of_clk_init(const struct of_device_id *matches)
@@ -2612,7 +2612,7 @@ void __init of_clk_init(const struct of_device_id *matches)
 		}
 
 		/*
-		 * We didn't managed to initialize any of the
+		 * We didn't manage to initialize any of the
 		 * remaining providers during the last loop, so now we
 		 * initialize all the remaining ones unconditionally
 		 * in case the clock parent was not mandatory
-- 
1.7.9.5
