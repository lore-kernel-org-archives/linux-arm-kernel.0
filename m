From: gilad@benyossef.com (Gilad Ben-Yossef)
Date: Thu, 24 May 2018 15:19:09 +0100
Subject: [PATCH v2 4/5] clk: renesas: r8a7795: add ccree clock bindings
In-Reply-To: <1527171551-21979-1-git-send-email-gilad@benyossef.com>
References: <1527171551-21979-1-git-send-email-gilad@benyossef.com>
Message-ID: <1527171551-21979-5-git-send-email-gilad@benyossef.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the clock used by the CryptoCell 630p instance in the SoC.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---

This patch depends upon the "clk: renesas: r8a7795: Add CR clock" patch
from Geert Uytterhoeven.

 drivers/clk/renesas/r8a7795-cpg-mssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/r8a7795-cpg-mssr.c b/drivers/clk/renesas/r8a7795-cpg-mssr.c
index e5b1865..a85dd50 100644
--- a/drivers/clk/renesas/r8a7795-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7795-cpg-mssr.c
@@ -133,6 +133,7 @@ static struct mssr_mod_clk r8a7795_mod_clks[] __initdata = {
 	DEF_MOD("sys-dmac2",		 217,	R8A7795_CLK_S0D3),
 	DEF_MOD("sys-dmac1",		 218,	R8A7795_CLK_S0D3),
 	DEF_MOD("sys-dmac0",		 219,	R8A7795_CLK_S0D3),
+	DEF_MOD("sceg-pub",		 229,	R8A7795_CLK_CR),
 	DEF_MOD("cmt3",			 300,	R8A7795_CLK_R),
 	DEF_MOD("cmt2",			 301,	R8A7795_CLK_R),
 	DEF_MOD("cmt1",			 302,	R8A7795_CLK_R),
-- 
2.7.4
