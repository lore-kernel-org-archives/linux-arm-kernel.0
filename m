From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Apr 2014 21:01:52 +0200
Subject: [PATCH 4/5] ARM: sun6i: Define the A31 CPUs enable-method
In-Reply-To: <1397847713-28418-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1397847713-28418-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1397847713-28418-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

That will allow to use the CPU_METHOD_OF_DECLARE definition we did previously.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index bc46814d2ff0..e88519cc6e70 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -27,6 +27,7 @@
 
 
 	cpus {
+		enable-method = "allwinner,sun6i-a31";
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-- 
1.9.1
