From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Mar 2014 15:29:57 +0900
Subject: [PATCH 1/2] ARM: shmobile: koelsch: Annotate clk_names with
 __initconst
In-Reply-To: <1394692198-30715-1-git-send-email-horms+renesas@verge.net.au>
References: <1394692198-30715-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1394692198-30715-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-koelsch-reference.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index a760f7f..1e6a436 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -85,7 +85,7 @@ static void __init koelsch_add_du_device(void)
  * This is a really crude hack to provide clkdev support to platform
  * devices until they get moved to DT.
  */
-static const struct clk_name clk_names[] = {
+static const struct clk_name clk_names[] __initconst = {
 	{ "cmt0", NULL, "sh_cmt.0" },
 	{ "scifa0", NULL, "sh-sci.0" },
 	{ "scifa1", NULL, "sh-sci.1" },
-- 
1.8.5.2
