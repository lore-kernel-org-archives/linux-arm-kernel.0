From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 26 Jun 2018 18:19:01 +0200
Subject: [PATCH 2/2] ARM: dts: stm32: Reorder nodes in stm32mp157c-ed1
In-Reply-To: <1530029941-26089-1-git-send-email-alexandre.torgue@st.com>
References: <1530029941-26089-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1530029941-26089-3-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nodes should be ordered in alphabetic order.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index 050c30d..de8b8a1 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -49,17 +49,6 @@
 	};
 };
 
-&rng1 {
-	status = "okay";
-};
-
-&timers6 {
-	status = "okay";
-	timer at 5 {
-		status = "okay";
-	};
-};
-
 &i2c4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c4_pins_a>;
@@ -68,10 +57,21 @@
 	status = "okay";
 };
 
+&rng1 {
+	status = "okay";
+};
+
 &rtc {
 	status = "okay";
 };
 
+&timers6 {
+	status = "okay";
+	timer at 5 {
+		status = "okay";
+	};
+};
+
 &uart4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart4_pins_a>;
-- 
2.7.4
