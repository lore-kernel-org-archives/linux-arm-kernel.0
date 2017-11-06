From: manu@freebsd.org (Emmanuel Vadot)
Date: Mon,  6 Nov 2017 21:51:39 +0100
Subject: [PATCH] ARM: dts: sunxi: Add codec for A13 Olinuxino
Message-ID: <20171106205139.82751-1-manu@freebsd.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A13 Olinuxino have an headphone jack and audio is supported
so enable it.

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index 38072c7e10e2..4b9af423c6d5 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -114,6 +114,10 @@
 	status = "okay";
 };
 
+&codec {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
-- 
2.14.1
