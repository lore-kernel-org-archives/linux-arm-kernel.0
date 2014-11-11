From: johan@kernel.org (Johan Hovold)
Date: Tue, 11 Nov 2014 16:56:04 +0100
Subject: [PATCH] ARM: OMAP2+: clock: remove unused function prototype
Message-ID: <1415721364-25749-1-git-send-email-johan@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unused function prototype that was left by commit 149c09d3a61d
("ARM: AM33xx: remove old clock data and link in new clock init code")
which removed the definition.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/arm/mach-omap2/clock.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 4592a2762592..c81d6cc41891 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -269,8 +269,6 @@ extern const struct clksel_rate div31_1to31_rates[];
 
 extern void __iomem *clk_memmaps[];
 
-extern int am33xx_clk_init(void);
-
 extern int omap2_clkops_enable_clkdm(struct clk_hw *hw);
 extern void omap2_clkops_disable_clkdm(struct clk_hw *hw);
 
-- 
2.0.4
