From: gilad@benyossef.com (Gilad Ben-Yossef)
Date: Tue, 15 May 2018 13:29:28 +0100
Subject: [PATCH 2/3] clk: renesas: r8a7795: Add ccree clock
In-Reply-To: <1526387370-17142-1-git-send-email-gilad@benyossef.com>
References: <1526387370-17142-1-git-send-email-gilad@benyossef.com>
Message-ID: <1526387370-17142-3-git-send-email-gilad@benyossef.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the clock used by the CryptoCell 630p instance in the SoC.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/clk/renesas/r8a7795-cpg-mssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/r8a7795-cpg-mssr.c b/drivers/clk/renesas/r8a7795-cpg-mssr.c
index 775b0ce..642706a 100644
--- a/drivers/clk/renesas/r8a7795-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7795-cpg-mssr.c
@@ -132,6 +132,7 @@ static struct mssr_mod_clk r8a7795_mod_clks[] __initdata = {
 	DEF_MOD("sys-dmac2",		 217,	R8A7795_CLK_S0D3),
 	DEF_MOD("sys-dmac1",		 218,	R8A7795_CLK_S0D3),
 	DEF_MOD("sys-dmac0",		 219,	R8A7795_CLK_S0D3),
+	DEF_MOD("ccree",		 229,	R8A7795_CLK_S3D2),
 	DEF_MOD("cmt3",			 300,	R8A7795_CLK_R),
 	DEF_MOD("cmt2",			 301,	R8A7795_CLK_R),
 	DEF_MOD("cmt1",			 302,	R8A7795_CLK_R),
-- 
2.7.4
