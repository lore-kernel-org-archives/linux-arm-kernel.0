From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 29 Apr 2015 14:08:31 +0530
Subject: [PATCH 4/5] ARM: EXYNOS: DTS: add SROM device node for exynos5
In-Reply-To: <1430296712-10287-1-git-send-email-pankaj.dubey@samsung.com>
References: <1430296712-10287-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1430296712-10287-5-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SROM device node for exynos5.

CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Ian Campbell <ijc+devicetree@hellion.org.uk>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/boot/dts/exynos5.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index a0cc0b6..d3be361 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -30,6 +30,11 @@
 		reg = <0x10000000 0x100>;
 	};
 
+	sromc at 12250000 {
+		compatible = "samsung,exynos-srom";
+		reg = <0x12250000 0x100>;
+	};
+
 	combiner: interrupt-controller at 10440000 {
 		compatible = "samsung,exynos4210-combiner";
 		#interrupt-cells = <2>;
-- 
2.2.0
