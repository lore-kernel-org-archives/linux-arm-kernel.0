From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed,  4 Jan 2017 18:21:27 -0600
Subject: [PATCH 05/12] ARM: dts: socfpga: enable watchdog timer on Arria5 and
 Arria10
In-Reply-To: <1483575694-29599-1-git-send-email-dinguyen@kernel.org>
References: <1483575694-29599-1-git-send-email-dinguyen@kernel.org>
Message-ID: <1483575694-29599-6-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the watchdog for Arria5 and Arria10.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi | 4 ++++
 arch/arm/boot/dts/socfpga_arria5.dtsi        | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
index eb00ae3..17ec17a 100644
--- a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
@@ -154,3 +154,7 @@
 &usb0 {
 	status = "okay";
 };
+
+&watchdog0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/socfpga_arria5.dtsi b/arch/arm/boot/dts/socfpga_arria5.dtsi
index 1907cc6..8c03729 100644
--- a/arch/arm/boot/dts/socfpga_arria5.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria5.dtsi
@@ -42,3 +42,7 @@
 		};
 	};
 };
+
+&watchdog0 {
+	status = "okay";
+};
-- 
2.7.4
