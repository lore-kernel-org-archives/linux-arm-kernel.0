From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Wed, 28 Nov 2012 19:59:48 +0530
Subject: [PATCH 2/3] ARM: EXYNOS: Add AUXDATA for G2D controller
In-Reply-To: <1354112989-3161-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1354112989-3161-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <1354112989-3161-2-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use AUXDATA to set the device names for G2D controller instance
discovered from device tree.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 arch/arm/mach-exynos/mach-exynos5-dt.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index 462e5ac..9eae2ce 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -110,6 +110,8 @@ static const struct of_dev_auxdata exynos5250_auxdata_lookup[] __initconst = {
 				"samsung-i2s.1", NULL),
 	OF_DEV_AUXDATA("samsung,samsung-i2s", 0x12D70000,
 				"samsung-i2s.2", NULL),
+	OF_DEV_AUXDATA("samsung,exynos-g2d-41", 0x10850000,
+				"s5p-g2d", NULL),
 	{},
 };
 
-- 
1.7.1
