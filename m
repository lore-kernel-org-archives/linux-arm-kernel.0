From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Thu, 29 Jul 2010 09:04:14 -0700
Subject: [PATCH 7/7] ARM: LPC32xx: Replace 'tbd's from audio clock names with
	NULL
In-Reply-To: <1280419454-1089-1-git-send-email-wellsk40@gmail.com>
References: <1280419454-1089-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1280419454-1089-8-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/clock.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
index e562d1b..043a5de 100644
--- a/arch/arm/mach-lpc32xx/clock.c
+++ b/arch/arm/mach-lpc32xx/clock.c
@@ -1091,8 +1091,8 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("dev:ssp1", NULL, clk_ssp1)
 	_REGISTER_CLOCK("lpc32xx_keys.0", NULL, clk_kscan)
 	_REGISTER_CLOCK("lpc32xx-nand.0", "nand_ck", clk_nand)
-	_REGISTER_CLOCK("tbd", "i2s0_ck", clk_i2s0)
-	_REGISTER_CLOCK("tbd", "i2s1_ck", clk_i2s1)
+	_REGISTER_CLOCK(NULL, "i2s0_ck", clk_i2s0)
+	_REGISTER_CLOCK(NULL, "i2s1_ck", clk_i2s1)
 	_REGISTER_CLOCK("lpc32xx-ts", NULL, clk_tsc)
 	_REGISTER_CLOCK("dev:mmc0", "MCLK", clk_mmc)
 	_REGISTER_CLOCK("lpc-net.0", NULL, clk_net)
-- 
1.7.1.1
