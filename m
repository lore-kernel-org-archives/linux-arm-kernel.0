From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 13 Oct 2015 00:12:34 +0300
Subject: [PATCH 05/37] ARM: dts: s5pv210-aquila: Fix typo in regulator enable
 GPIO property
In-Reply-To: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1444684386-17094-6-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The property name should be "gpio", not "gpios". Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/s5pv210-aquila.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Cc: linux-samsung-soc at vger.kernel.org
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

diff --git a/arch/arm/boot/dts/s5pv210-aquila.dts b/arch/arm/boot/dts/s5pv210-aquila.dts
index f00cea7aca2f..aa64faa72970 100644
--- a/arch/arm/boot/dts/s5pv210-aquila.dts
+++ b/arch/arm/boot/dts/s5pv210-aquila.dts
@@ -46,7 +46,7 @@
 			regulator-name = "V_TF_2.8V";
 			regulator-min-microvolt = <2800000>;
 			regulator-max-microvolt = <2800000>;
-			gpios = <&mp05 4 0>;
+			gpio = <&mp05 4 0>;
 			enable-active-high;
 		};
 
-- 
2.4.9
