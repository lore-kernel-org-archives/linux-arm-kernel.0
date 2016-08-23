From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 23 Aug 2016 09:49:43 +0200
Subject: [PATCH/RFT v2 1/8] clk: renesas: r8a7796: Add GPIO clocks
In-Reply-To: <1471938590-10650-1-git-send-email-horms+renesas@verge.net.au>
References: <1471938590-10650-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1471938590-10650-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

Add GPIO clocks for the R8A7796 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/renesas/r8a7796-cpg-mssr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/renesas/r8a7796-cpg-mssr.c b/drivers/clk/renesas/r8a7796-cpg-mssr.c
index c0dee762ed23..999955c2b23e 100644
--- a/drivers/clk/renesas/r8a7796-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7796-cpg-mssr.c
@@ -106,6 +106,14 @@ static const struct mssr_mod_clk r8a7796_mod_clks[] __initconst = {
 	DEF_MOD("scif2",		 310,	R8A7796_CLK_S3D4),
 	DEF_MOD("rwdt0",		 402,	R8A7796_CLK_R),
 	DEF_MOD("intc-ap",		 408,	R8A7796_CLK_S3D1),
+	DEF_MOD("gpio7",		 905,	R8A7796_CLK_S3D4),
+	DEF_MOD("gpio6",		 906,	R8A7796_CLK_S3D4),
+	DEF_MOD("gpio5",		 907,	R8A7796_CLK_S3D4),
+	DEF_MOD("gpio4",		 908,	R8A7796_CLK_S3D4),
+	DEF_MOD("gpio3",		 909,	R8A7796_CLK_S3D4),
+	DEF_MOD("gpio2",		 910,	R8A7796_CLK_S3D4),
+	DEF_MOD("gpio1",		 911,	R8A7796_CLK_S3D4),
+	DEF_MOD("gpio0",		 912,	R8A7796_CLK_S3D4),
 };
 
 static const unsigned int r8a7796_crit_mod_clks[] __initconst = {
-- 
2.7.0.rc3.207.g0ac5344
