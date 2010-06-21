From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 22 Jun 2010 08:43:54 +0900
Subject: [PATCH 3/4] ARM: S5PC100: Rename keypad clock for S5PC100.
In-Reply-To: <1277163835-12439-1-git-send-email-kgene.kim@samsung.com>
References: <1277163835-12439-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1277163835-12439-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naveen Krishna Ch <ch.naveen@samsung.com>

This patch renames the keypad clock for S5PC100 from keyif to keypad.

Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pc100/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5pc100/clock.c b/arch/arm/mach-s5pc100/clock.c
index e3fed4c..e1136f4 100644
--- a/arch/arm/mach-s5pc100/clock.c
+++ b/arch/arm/mach-s5pc100/clock.c
@@ -737,7 +737,7 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s5pc100_d1_5_ctrl,
 		.ctrlbit	= (1 << 7),
 	}, {
-		.name		= "keyif",
+		.name		= "keypad",
 		.id		= -1,
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_5_ctrl,
-- 
1.6.2.5
