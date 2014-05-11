From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 11 May 2014 09:46:53 +0200
Subject: [PATCH v12 2/6] ARM: dts: sunxi: Add reg_vcc3v3 supply to
 sunxi-common-regulators.dtsi
In-Reply-To: <1399794417-9291-1-git-send-email-hdegoede@redhat.com>
References: <1399794417-9291-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1399794417-9291-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sunxi-common-regulators.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-common-regulators.dtsi b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
index 18eeac0..026bd83 100644
--- a/arch/arm/boot/dts/sunxi-common-regulators.dtsi
+++ b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
@@ -72,4 +72,11 @@
 		gpio = <&pio 7 3 0>;
 		status = "disabled";
 	};
+
+	reg_vcc3v3: vcc3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 };
-- 
1.9.0
