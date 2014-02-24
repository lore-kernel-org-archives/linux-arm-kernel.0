From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 24 Feb 2014 20:57:11 +0100
Subject: [PATCH] clk: shmobile: div6: use proper description in kernel doc
Message-ID: <1393271848-13313-1-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

These variable clocks have nothing to do with MSTP gating, probably a
copy&paste leftover.

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---
 drivers/clk/shmobile/clk-div6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/shmobile/clk-div6.c b/drivers/clk/shmobile/clk-div6.c
index aac4756..f065f69 100644
--- a/drivers/clk/shmobile/clk-div6.c
+++ b/drivers/clk/shmobile/clk-div6.c
@@ -23,7 +23,7 @@
 #define CPG_DIV6_DIV_MASK	0x3f
 
 /**
- * struct div6_clock - MSTP gating clock
+ * struct div6_clock - CPG 6 bit divider clock
  * @hw: handle between common and hardware-specific interfaces
  * @reg: IO-remapped register
  * @div: divisor value (1-64)
-- 
1.8.5.1
