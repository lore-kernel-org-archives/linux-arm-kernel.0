From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon, 15 Jan 2018 11:33:50 +0100
Subject: [PATCH v3 16/16] ARM: dtsi: axp81x: remove IP name from DT node name
In-Reply-To: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
References: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
Message-ID: <6e881951c43b8829cd509c3db06fa5520f71e779.1516012352.git-series.quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DT node should be named after its functionality and not after the
IP it's defining.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/axp81x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/axp81x.dtsi b/arch/arm/boot/dts/axp81x.dtsi
index 1b05c7f..043c717 100644
--- a/arch/arm/boot/dts/axp81x.dtsi
+++ b/arch/arm/boot/dts/axp81x.dtsi
@@ -53,7 +53,7 @@
 		#io-channel-cells = <1>;
 	};
 
-	axp_gpio: axp-gpio {
+	axp_gpio: gpio {
 		compatible = "x-powers,axp813-gpio";
 		gpio-controller;
 		#gpio-cells = <2>;
-- 
git-series 0.9.1
