From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 16 Feb 2014 10:40:58 +0100
Subject: [PATCH 5/5] ARM: shmobile: r8a7790: add i2c aliases to dtsi
In-Reply-To: <1392543658-5030-1-git-send-email-wsa@the-dreams.de>
References: <1392543658-5030-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1392543658-5030-6-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index a6e3713..a1e7c39 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -18,6 +18,13 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.8.5.1
