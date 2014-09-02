From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Tue,  2 Sep 2014 16:02:08 -0700
Subject: [PATCH 2/3] clk: zynq: Remove pointless return at end of void function
In-Reply-To: <1409698929-30143-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1409698929-30143-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1409698929-30143-3-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/clk/zynq/clkc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
index 246cf1226eaa..6ab793ac8c2c 100644
--- a/drivers/clk/zynq/clkc.c
+++ b/drivers/clk/zynq/clkc.c
@@ -619,5 +619,4 @@ void __init zynq_clock_init(void)
 np_err:
 	of_node_put(np);
 	BUG();
-	return;
 }
-- 
2.1.0.1.g27b9230
