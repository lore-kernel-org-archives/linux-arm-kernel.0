From: bd-phuc@jinso.co.jp (bd-phuc at jinso.co.jp)
Date: Fri,  9 Sep 2016 20:43:10 +0900
Subject: [PATCH 4/8] clk: renesas: r8a7795: Add CMT clocks
In-Reply-To: <1473421394-9745-1-git-send-email-bd-phuc@jinso.co.jp>
References: <1473421394-9745-1-git-send-email-bd-phuc@jinso.co.jp>
Message-ID: <1473421394-9745-5-git-send-email-bd-phuc@jinso.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bui Duc Phuc <bd-phuc@jinso.co.jp>

This patch adds CMT module clocks for r8a7795 SoC.

Signed-off-by: Bui Duc Phuc <bd-phuc@jinso.co.jp>
---
 drivers/clk/renesas/r8a7795-cpg-mssr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/renesas/r8a7795-cpg-mssr.c b/drivers/clk/renesas/r8a7795-cpg-mssr.c
index e38bf60..86968ea 100644
--- a/drivers/clk/renesas/r8a7795-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7795-cpg-mssr.c
@@ -123,6 +123,10 @@ static const struct mssr_mod_clk r8a7795_mod_clks[] __initconst = {
 	DEF_MOD("sys-dmac2",		 217,	R8A7795_CLK_S3D1),
 	DEF_MOD("sys-dmac1",		 218,	R8A7795_CLK_S3D1),
 	DEF_MOD("sys-dmac0",		 219,	R8A7795_CLK_S3D1),
+	DEF_MOD("cmt3",		 	 300,	R8A7795_CLK_R),
+	DEF_MOD("cmt2",		 	 301,	R8A7795_CLK_R),
+	DEF_MOD("cmt1",		 	 302,	R8A7795_CLK_R),
+	DEF_MOD("cmt0",		 	 303,	R8A7795_CLK_R),
 	DEF_MOD("scif2",		 310,	R8A7795_CLK_S3D4),
 	DEF_MOD("sdif3",		 311,	R8A7795_CLK_SD3),
 	DEF_MOD("sdif2",		 312,	R8A7795_CLK_SD2),
-- 
2.7.4
