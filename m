From: jhbird.choi@samsung.com (jhbird.choi at samsung.com)
Date: Tue, 26 Jul 2011 18:12:42 +0900
Subject: [PATCH] ARM: EXYNOS4: Fix wrong devname to support clkdev
Message-ID: <1311671562-1483-1-git-send-email-jhbird.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonghwan Choi <jhbird.choi@samsung.com>

Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
---
 arch/arm/mach-exynos4/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
index 66494f2..8e9699e 100644
--- a/arch/arm/mach-exynos4/clock.c
+++ b/arch/arm/mach-exynos4/clock.c
@@ -520,7 +520,7 @@ static struct clk init_clocks_off[] = {
 		.ctrlbit	= (1 << 21),
 	}, {
 		.name		= "ac97",
-		.id		= -1,
+		.devname	= "samsung-ac97",
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 27),
 	}, {
-- 
1.7.1
