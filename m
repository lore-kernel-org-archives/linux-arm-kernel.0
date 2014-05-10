From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 10 May 2014 15:46:25 +0900
Subject: [PATCH v3 3/3] Documentation: update samsung pmu binding information
In-Reply-To: <1399704385-12508-1-git-send-email-pankaj.dubey@samsung.com>
References: <1399704385-12508-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1399704385-12508-4-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates samsung pmu (power management unit) binding information.

CC: Leela Krishna Amudala <l.krishna@samsung.com>
CC: Tomasz Figa <t.figa@samsung.com>
CC: Guenter Roeck <linux@roeck-us.net>
CC: Rob Landley <rob@landley.net>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 Documentation/devicetree/bindings/arm/samsung/pmu.txt |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
index f1f1552..b562634 100644
--- a/Documentation/devicetree/bindings/arm/samsung/pmu.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
@@ -2,6 +2,9 @@ SAMSUNG Exynos SoC series PMU Registers
 
 Properties:
  - compatible : should contain two values. First value must be one from following list:
+		   - "samsung,exynos4210-pmu" - for Exynos4210 SoC,
+		   - "samsung,exynos4212-pmu" - for Exynos4212 SoC,
+		   - "samsung,exynos4412-pmu" - for Exynos4412 SoC,
 		   - "samsung,exynos5250-pmu" - for Exynos5250 SoC,
 		   - "samsung,exynos5420-pmu" - for Exynos5420 SoC.
 		second value must be always "syscon".
-- 
1.7.10.4
