From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon,  2 Oct 2017 14:08:51 +0200
Subject: [PATCH v3 09/12] ARM: dts: sun8i: h8homlet-v2: include axp81x dtsi
In-Reply-To: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
References: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
Message-ID: <20171002120854.5212-10-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This board has an AXP818 PMIC so let's include its dtsi.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts b/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts
index 1f0d60afb25b..222a983c3c6d 100644
--- a/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts
@@ -131,6 +131,8 @@
 	};
 };
 
+#include "axp81x.dtsi"
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.11.0
