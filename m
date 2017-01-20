From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 20 Jan 2017 15:08:20 +0100
Subject: [PATCH 2/8] clk: renesas: cpg-mssr: Document suitability for RZ/G1
In-Reply-To: <1484921306-9967-1-git-send-email-geert+renesas@glider.be>
References: <1484921306-9967-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1484921306-9967-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Renesas CPG/MSSR driver is already in active use for RZ/G1 since
commits c0b2d75d2a4bf6a3 ("clk: renesas: cpg-mssr: Add R8A7743 support")
and 9127d54bb8947159 ("clk: renesas: cpg-mssr: Add R8A7745 support").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/renesas/renesas-cpg-mssr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 6947482d48a55094..eb8534e5ebf3007d 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -43,7 +43,7 @@
  * Module Standby and Software Reset register offets.
  *
  * If the registers exist, these are valid for SH-Mobile, R-Mobile,
- * R-Car Gen 2, and R-Car Gen 3.
+ * R-Car Gen2, R-Car Gen3, and RZ/G1.
  * These are NOT valid for R-Car Gen1 and RZ/A1!
  */
 
-- 
1.9.1
