From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 29 Apr 2015 14:08:30 +0530
Subject: [PATCH 3/5] ARM: EXYNOS: DTS: add SROM device node for exynos4
In-Reply-To: <1430296712-10287-1-git-send-email-pankaj.dubey@samsung.com>
References: <1430296712-10287-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1430296712-10287-4-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SROM device node for exynos4.

CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Ian Campbell <ijc+devicetree@hellion.org.uk>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 77ea547..48490ea 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -76,6 +76,11 @@
 		reg = <0x10000000 0x100>;
 	};
 
+	sromc at 12570000 {
+		compatible = "samsung,exynos-srom";
+		reg = <0x12570000 0x100>;
+	};
+
 	mipi_phy: video-phy at 10020710 {
 		compatible = "samsung,s5pv210-mipi-video-phy";
 		reg = <0x10020710 8>;
-- 
2.2.0
