From: codekipper@gmail.com (codekipper at gmail.com)
Date: Tue,  8 Dec 2015 19:29:04 +0100
Subject: [linux-sunxi][PATCH 2/2] ARM: dts: sun7i: Add audio codec to Itead
 Ibox
In-Reply-To: <1449599344-15544-1-git-send-email-codekipper@gmail.com>
References: <1449599344-15544-1-git-send-email-codekipper@gmail.com>
Message-ID: <1449599344-15544-2-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts b/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
index 90ff677..0950b59 100644
--- a/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
+++ b/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
@@ -70,6 +70,10 @@
 	status = "okay";
 };
 
+&codec {
+	status = "okay";
+};
+
 &gmac {
 	pinctrl-names = "default";
 	pinctrl-0 = <&gmac_pins_mii_a>;
-- 
2.6.3
