From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 19 Dec 2012 21:18:15 +0100
Subject: [PATCH 6/6] ARM: sunxi: olinuxino: Add muxing for the uart
In-Reply-To: <1355948295-19680-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1355948295-19680-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1355948295-19680-7-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index 498a091..4a1e45d 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -24,6 +24,8 @@
 
 	soc {
 		uart1: uart at 01c28400 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart1_pins_b>;
 			status = "okay";
 		};
 	};
-- 
1.7.9.5
