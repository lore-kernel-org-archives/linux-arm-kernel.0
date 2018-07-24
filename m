From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 24 Jul 2018 18:49:43 +0200
Subject: [PATCH v2 1/4] ARM: exynos: Remove outdated maintainer information
Message-ID: <20180724164946.6274-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current maintainers are specified in MAINTAINERS file, so remove
in-sources information with outdated e-mail address (Thomas Abraham's
email does not work, Kukjin Kim uses @kernel.org).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
New patch.
---
 arch/arm/mach-exynos/exynos.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index f4b6c93a7fd0..865dcc4c3181 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -190,8 +190,6 @@ static void __init exynos_dt_fixup(void)
 }
 
 DT_MACHINE_START(EXYNOS_DT, "SAMSUNG EXYNOS (Flattened Device Tree)")
-	/* Maintainer: Thomas Abraham <thomas.abraham@linaro.org> */
-	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
 	.l2c_aux_val	= 0x3c400001,
 	.l2c_aux_mask	= 0xc20fffff,
 	.smp		= smp_ops(exynos_smp_ops),
-- 
2.14.1
