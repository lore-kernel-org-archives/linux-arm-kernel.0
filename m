From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 10 May 2014 11:33:59 +0200
Subject: [PATCH v11 2/6] ARM: dts: sunxi: Add reg_vmmc0 supply to
 sunxi-common-regulators.dtsi
In-Reply-To: <1399714443-12459-1-git-send-email-hdegoede@redhat.com>
References: <1399714443-12459-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1399714443-12459-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sunxi-common-regulators.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-common-regulators.dtsi b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
index 18eeac0..ebbba39 100644
--- a/arch/arm/boot/dts/sunxi-common-regulators.dtsi
+++ b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
@@ -72,4 +72,12 @@
 		gpio = <&pio 7 3 0>;
 		status = "disabled";
 	};
+
+	reg_vmmc0: vmmc0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmc0";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		status = "disabled";
+	};
 };
-- 
1.9.0
