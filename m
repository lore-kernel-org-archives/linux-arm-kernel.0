From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Fri, 27 Jan 2017 09:54:57 +0100
Subject: [PATCH v2 24/25] ARM: dts: sun8i: sina33: enable battery power supply
 subnode
In-Reply-To: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
Message-ID: <20170127085458.18270-25-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Sinlinx SinA33 has an AXP223 PMIC and a battery connector, thus, we
enable the battery power supply subnode in its Device Tree.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
index bf53408..2fe9299 100644
--- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
+++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
@@ -151,6 +151,10 @@
 	status = "okay";
 };
 
+&battery_power_supply {
+	status = "okay";
+};
+
 &reg_aldo1 {
 	regulator-always-on;
 	regulator-min-microvolt = <3000000>;
-- 
2.9.3
