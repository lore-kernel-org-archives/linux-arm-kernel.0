From: ulrich.hecht+renesas@gmail.com (Ulrich Hecht)
Date: Mon, 14 Dec 2015 16:42:33 +0100
Subject: [PATCH 1/6] clk: shmobile: r8a7795: Add SATA0 clock
In-Reply-To: <1450107758-2544-1-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1450107758-2544-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Message-ID: <1450107758-2544-2-git-send-email-ulrich.hecht+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/clk/shmobile/r8a7795-cpg-mssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/shmobile/r8a7795-cpg-mssr.c b/drivers/clk/shmobile/r8a7795-cpg-mssr.c
index 05479e6..ad4d9fd 100644
--- a/drivers/clk/shmobile/r8a7795-cpg-mssr.c
+++ b/drivers/clk/shmobile/r8a7795-cpg-mssr.c
@@ -159,6 +159,7 @@ static const struct mssr_mod_clk r8a7795_mod_clks[] __initconst = {
 	DEF_MOD("gpio2",		 910,	R8A7795_CLK_CP),
 	DEF_MOD("gpio1",		 911,	R8A7795_CLK_CP),
 	DEF_MOD("gpio0",		 912,	R8A7795_CLK_CP),
+	DEF_MOD("sata0",		 915,	R8A7795_CLK_S3D2),
 	DEF_MOD("i2c6",			 918,	R8A7795_CLK_S3D2),
 	DEF_MOD("i2c5",			 919,	R8A7795_CLK_S3D2),
 	DEF_MOD("i2c4",			 927,	R8A7795_CLK_S3D2),
-- 
2.6.3
