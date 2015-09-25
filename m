From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 25 Sep 2015 20:35:34 +0300
Subject: [PATCH 5/5] ARM: dts: WM8750: fix cpu compatible value
In-Reply-To: <1443202506-13732-1-git-send-email-vz@mleia.com>
References: <1443202506-13732-1-git-send-email-vz@mleia.com>
Message-ID: <1443202534-13816-5-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change corrects cpu compatible property to a defined one,
see Documentation/devicetree/bindings/arm/cpus.txt

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/wm8750.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/wm8750.dtsi b/arch/arm/boot/dts/wm8750.dtsi
index 557a9c2a..46d076d 100644
--- a/arch/arm/boot/dts/wm8750.dtsi
+++ b/arch/arm/boot/dts/wm8750.dtsi
@@ -17,7 +17,7 @@
 
 		cpu {
 			device_type = "cpu";
-			compatible = "arm,arm1176ej-s";
+			compatible = "arm,arm1176jzf";
 		};
 	};
 
-- 
2.1.4
