From: codekipper@gmail.com (codekipper at gmail.com)
Date: Sat, 19 Dec 2015 14:08:46 +0100
Subject: [linux-sunxi][PATCH v2] ARM: dt: sun7i: Enable audio codec on MK808C
Message-ID: <1450530526-28267-1-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

This commit enables the on-chip audio codec present on the MK808C.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20-mk808c.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-mk808c.dts b/arch/arm/boot/dts/sun7i-a20-mk808c.dts
index 4f432f8..c9e648d 100644
--- a/arch/arm/boot/dts/sun7i-a20-mk808c.dts
+++ b/arch/arm/boot/dts/sun7i-a20-mk808c.dts
@@ -68,6 +68,10 @@
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
