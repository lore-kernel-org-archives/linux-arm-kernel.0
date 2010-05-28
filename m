From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 28 May 2010 11:41:16 +0900
Subject: [PATCH 3/4] ARM: S5P: Add clk_xusbxti clock to the list of clocks to
	be registered.
In-Reply-To: <1275014477-23133-1-git-send-email-kgene.kim@samsung.com>
References: <1275014477-23133-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1275014477-23133-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

The clk_xusbxti clock is added to the list of clocks to be
registred during boot time clock registration.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-s5p/clock.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s5p/clock.c b/arch/arm/plat-s5p/clock.c
index 24a931f..b5e2552 100644
--- a/arch/arm/plat-s5p/clock.c
+++ b/arch/arm/plat-s5p/clock.c
@@ -148,6 +148,7 @@ static struct clk *s5p_clks[] __initdata = {
 	&clk_fout_vpll,
 	&clk_arm,
 	&clk_vpll,
+	&clk_xusbxti,
 };
 
 void __init s5p_register_clocks(unsigned long xtal_freq)
-- 
1.6.3.3
