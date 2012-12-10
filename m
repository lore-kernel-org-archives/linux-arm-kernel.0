From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Dec 2012 23:08:21 +0100
Subject: [PATCH 6/6] ARM: sunxi: olinuxino: Add muxing for the uart
In-Reply-To: <1355177301-31928-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1355177301-31928-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1355177301-31928-7-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-olinuxino.dts |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-olinuxino.dts b/arch/arm/boot/dts/sun5i-olinuxino.dts
index d6ff889..598c1aa 100644
--- a/arch/arm/boot/dts/sun5i-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-olinuxino.dts
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
