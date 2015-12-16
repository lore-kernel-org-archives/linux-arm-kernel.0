From: ulrich.hecht+renesas@gmail.com (Ulrich Hecht)
Date: Wed, 16 Dec 2015 11:34:20 +0100
Subject: [PATCH v2 1/2] clk: shmobile: r8a7795: Add SATA0 clock
In-Reply-To: <1450262061-1441-1-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1450262061-1441-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Message-ID: <1450262061-1441-2-git-send-email-ulrich.hecht+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/clk/shmobile/r8a7795-cpg-mssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/shmobile/r8a7795-cpg-mssr.c b/drivers/clk/shmobile/r8a7795-cpg-mssr.c
index 05479e6..23e98fe 100644
--- a/drivers/clk/shmobile/r8a7795-cpg-mssr.c
+++ b/drivers/clk/shmobile/r8a7795-cpg-mssr.c
@@ -151,6 +151,7 @@ static const struct mssr_mod_clk r8a7795_mod_clks[] __initconst = {
 	DEF_MOD("hdmi1",		 728,	R8A7795_CLK_HDMI),
 	DEF_MOD("hdmi0",		 729,	R8A7795_CLK_HDMI),
 	DEF_MOD("etheravb",		 812,	R8A7795_CLK_S3D2),
+	DEF_MOD("sata0",		 815,	R8A7795_CLK_S3D2),
 	DEF_MOD("gpio7",		 905,	R8A7795_CLK_CP),
 	DEF_MOD("gpio6",		 906,	R8A7795_CLK_CP),
 	DEF_MOD("gpio5",		 907,	R8A7795_CLK_CP),
-- 
2.6.3
