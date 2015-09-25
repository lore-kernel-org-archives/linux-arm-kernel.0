From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 25 Sep 2015 20:35:32 +0300
Subject: [PATCH 3/5] ARM: dts: S3C2416: fix cpu compatible value
In-Reply-To: <1443202506-13732-1-git-send-email-vz@mleia.com>
References: <1443202506-13732-1-git-send-email-vz@mleia.com>
Message-ID: <1443202534-13816-3-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change corrects cpu compatible property to a defined one,
see Documentation/devicetree/bindings/arm/cpus.txt

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/s3c2416.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/s3c2416.dtsi b/arch/arm/boot/dts/s3c2416.dtsi
index a5184ff..80f0075 100644
--- a/arch/arm/boot/dts/s3c2416.dtsi
+++ b/arch/arm/boot/dts/s3c2416.dtsi
@@ -25,7 +25,7 @@
 		#size-cells = <0>;
 
 		cpu {
-			compatible = "arm,arm926ejs";
+			compatible = "arm,arm926ej-s";
 		};
 	};
 
-- 
2.1.4
