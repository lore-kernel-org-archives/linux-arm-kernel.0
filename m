From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 14 Oct 2013 18:30:09 +0800
Subject: [PATCH] clk / clkdev: fix the comments in clk_register_clkdev
Message-ID: <1381746609-21498-1-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'dev_id' in the comments of clk_register_clkdev should
be 'dev_fmt' here.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/clk/clkdev.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 442a313..825b52b 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -270,9 +270,9 @@ EXPORT_SYMBOL(clkdev_drop);
  * clk_register_clkdev - register one clock lookup for a struct clk
  * @clk: struct clk to associate with all clk_lookups
  * @con_id: connection ID string on device
- * @dev_id: format string describing device name
+ * @dev_fmt: format string describing device name
  *
- * con_id or dev_id may be NULL as a wildcard, just as in the rest of
+ * con_id or dev_fmt may be NULL as a wildcard, just as in the rest of
  * clkdev.
  *
  * To make things easier for mass registration, we detect error clks
-- 
1.7.9.5
