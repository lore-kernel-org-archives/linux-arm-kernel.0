From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 18 Dec 2013 22:48:37 +0100
Subject: [PATCH] arm: shmobile: clks: remove duplicated clock from r7s72100
Message-ID: <1387403317-24485-1-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 arch/arm/mach-shmobile/clock-r7s72100.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r7s72100.c b/arch/arm/mach-shmobile/clock-r7s72100.c
index 9cda215..dd8ce87 100644
--- a/arch/arm/mach-shmobile/clock-r7s72100.c
+++ b/arch/arm/mach-shmobile/clock-r7s72100.c
@@ -191,7 +191,6 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("sci_fck", "sh-sci.5", &mstp_clks[MSTP42]),
 	CLKDEV_ICK_ID("sci_fck", "sh-sci.6", &mstp_clks[MSTP41]),
 	CLKDEV_ICK_ID("sci_fck", "sh-sci.7", &mstp_clks[MSTP40]),
-	CLKDEV_CON_ID("mtu2_fck", &mstp_clks[MSTP33]),
 };
 
 void __init r7s72100_clock_init(void)
-- 
1.8.4.2
