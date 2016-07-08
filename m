From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  8 Jul 2016 18:05:50 +0200
Subject: [PATCH 09/15] ARM: dts: sun8i: reference-design-tablet: Add
 drivevbus-supply
In-Reply-To: <1467993956-19535-1-git-send-email-hdegoede@redhat.com>
References: <1467993956-19535-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1467993956-19535-10-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a drivevbus-supply property so that the drivevbus regulator
reports the right voltage value.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
index b8546ef..9d90361 100644
--- a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
@@ -105,6 +105,7 @@
 		interrupt-parent = <&nmi_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 		eldoin-supply = <&reg_dcdc1>;
+		drivevbus-supply = <&reg_vcc5v0>;
 		x-powers,drive-vbus-en;
 	};
 };
-- 
2.7.4
