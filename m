From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 15:07:06 +0900
Subject: [PATCH 13/13] arm: shmobile: clks: remove duplicated clock from
 r7s72100
In-Reply-To: <cover.1387857168.git.horms+renesas@verge.net.au>
References: <cover.1387857168.git.horms+renesas@verge.net.au>
Message-ID: <250d829f68ecb5e775a99deb03c56832acec28f4.1387857168.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa@the-dreams.de>

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r7s72100.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r7s72100.c b/arch/arm/mach-shmobile/clock-r7s72100.c
index 1c9d261..4aba20c 100644
--- a/arch/arm/mach-shmobile/clock-r7s72100.c
+++ b/arch/arm/mach-shmobile/clock-r7s72100.c
@@ -178,7 +178,6 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("sci_fck", "sh-sci.5", &mstp_clks[MSTP42]),
 	CLKDEV_ICK_ID("sci_fck", "sh-sci.6", &mstp_clks[MSTP41]),
 	CLKDEV_ICK_ID("sci_fck", "sh-sci.7", &mstp_clks[MSTP40]),
-	CLKDEV_CON_ID("mtu2_fck", &mstp_clks[MSTP33]),
 };
 
 void __init r7s72100_clock_init(void)
-- 
1.8.4
