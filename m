From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 26 Sep 2017 14:17:19 +0200
Subject: [PATCH v2 09/10] ARM: dts: sun8i: a711: include axp813 dtsi
In-Reply-To: <cover.1c314f4154a6d27354625f03d0a5269eee55a9c5.1506428208.git-series.quentin.schulz@free-electrons.com>
References: <cover.1c314f4154a6d27354625f03d0a5269eee55a9c5.1506428208.git-series.quentin.schulz@free-electrons.com>
Message-ID: <b8e3c3cd48a8cf389d3129c7f7ab49c2efb8b688.1506428208.git-series.quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This board has an AXP813 PMIC so let's include its dtsi.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index 723641f..d9f8ed3 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -179,6 +179,8 @@
 
 };
 
+#include "axp813.dtsi"
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
git-series 0.9.1
