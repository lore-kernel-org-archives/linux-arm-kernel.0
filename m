From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Apr 2014 07:44:55 +0900
Subject: [PATCH 06/14] ARM: shmobile: koelsch-reference: Annotate clk_enables
 as __initconst
In-Reply-To: <cover.1397774190.git.horms+renesas@verge.net.au>
References: <cover.1397774190.git.horms+renesas@verge.net.au>
Message-ID: <9e7b83c221cc257f4dc37acc82bbcb80627c0ab9.1397774191.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/arm/mach-shmobile/board-koelsch-reference.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index a39114a..63117d52 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -110,7 +110,7 @@ static const struct clk_name clk_names[] __initconst = {
 /*
  * This is a really crude hack to work around core platform clock issues
  */
-static const struct clk_name clk_enables[] = {
+static const struct clk_name clk_enables[] __initconst = {
 	{ "ether", NULL, "ee700000.ethernet" },
 	{ "i2c2", NULL, "e6530000.i2c" },
 	{ "msiof0", NULL, "e6e20000.spi" },
-- 
1.8.4
