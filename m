From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon,  2 Oct 2017 14:08:50 +0200
Subject: [PATCH v3 08/12] ARM: dts: sun8i: bananapi-m3: include axp81x dtsi
In-Reply-To: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
References: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
Message-ID: <20171002120854.5212-9-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This board has an AXP813 PMIC so let's include its dtsi.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
index 2bafd7e99ef7..bf8f3b9a65dd 100644
--- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
@@ -123,6 +123,8 @@
 	};
 };
 
+#include "axp81x.dtsi"
+
 &reg_usb1_vbus {
 	gpio = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
 	status = "okay";
-- 
2.11.0
