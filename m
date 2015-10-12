From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 13 Oct 2015 00:12:35 +0300
Subject: [PATCH 06/37] ARM: dts: s5pv210-goni: Fix typo in regulator enable
 GPIO property
In-Reply-To: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1444684386-17094-7-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The property name should be "gpio", not "gpios". Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/s5pv210-goni.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Cc: linux-samsung-soc at vger.kernel.org
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

diff --git a/arch/arm/boot/dts/s5pv210-goni.dts b/arch/arm/boot/dts/s5pv210-goni.dts
index a3d4643b202e..3b76eeeb8410 100644
--- a/arch/arm/boot/dts/s5pv210-goni.dts
+++ b/arch/arm/boot/dts/s5pv210-goni.dts
@@ -47,7 +47,7 @@
 			regulator-min-microvolt = <2800000>;
 			regulator-max-microvolt = <2800000>;
 			reg = <0>;
-			gpios = <&mp05 4 0>;
+			gpio = <&mp05 4 0>;
 			enable-active-high;
 		};
 
@@ -73,7 +73,7 @@
 			regulator-min-microvolt = <2800000>;
 			regulator-max-microvolt = <2800000>;
 			reg = <3>;
-			gpios = <&gpj1 3 0>;
+			gpio = <&gpj1 3 0>;
 			enable-active-high;
 		};
 	};
-- 
2.4.9
