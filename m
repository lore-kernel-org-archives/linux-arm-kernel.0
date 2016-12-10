From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 10 Dec 2016 16:16:00 +0530
Subject: [PATCH v2 1/3] Documentation: bindings: Add binding doc for exynos
 enable method
In-Reply-To: <1481366762-26413-1-git-send-email-pankaj.dubey@samsung.com>
References: <1481366762-26413-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1481366762-26413-2-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "samsung,exynos-smp" as enable-method for Samsung's Exynos SoC.

CC: Rob Herring <robh+dt@kernel.org> 
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index e6782d5..12730c8 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -209,6 +209,7 @@ nodes to be present and contain the properties described below.
 			    "renesas,apmu"
 			    "rockchip,rk3036-smp"
 			    "rockchip,rk3066-smp"
+			    "samsung,exynos-smp"
 			    "ste,dbx500-smp"
 
 	- cpu-release-addr
-- 
2.7.4
