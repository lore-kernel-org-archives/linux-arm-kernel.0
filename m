From: codekipper@gmail.com (codekipper at gmail.com)
Date: Sat, 19 Dec 2015 14:02:38 +0100
Subject: [linux-sunxi][PATCH v2] ARM: sunxi: dt: enable audio codec on mk802
Message-ID: <1450530158-7639-1-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

This commit enables the on-chip audio codec present on some variants
of the MK802.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/sun4i-a10-mk802.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-mk802.dts b/arch/arm/boot/dts/sun4i-a10-mk802.dts
index 3c7eebe..ddf0683 100644
--- a/arch/arm/boot/dts/sun4i-a10-mk802.dts
+++ b/arch/arm/boot/dts/sun4i-a10-mk802.dts
@@ -58,6 +58,10 @@
 	};
 };
 
+&codec {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
-- 
2.6.4
