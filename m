From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 25 Sep 2015 20:35:33 +0300
Subject: [PATCH 4/5] ARM: dts: TI-Nspire: fix cpu compatible value
In-Reply-To: <1443202506-13732-1-git-send-email-vz@mleia.com>
References: <1443202506-13732-1-git-send-email-vz@mleia.com>
Message-ID: <1443202534-13816-4-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change corrects cpu compatible property to a defined one,
see Documentation/devicetree/bindings/arm/cpus.txt

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/nspire.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nspire.dtsi b/arch/arm/boot/dts/nspire.dtsi
index 390c91a..ee5a0bb 100644
--- a/arch/arm/boot/dts/nspire.dtsi
+++ b/arch/arm/boot/dts/nspire.dtsi
@@ -16,7 +16,7 @@
 
 	cpus {
 		cpu at 0 {
-			compatible = "arm,arm926ejs";
+			compatible = "arm,arm926ej-s";
 		};
 	};
 
-- 
2.1.4
