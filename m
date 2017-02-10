From: net147@gmail.com (Jonathan Liu)
Date: Fri, 10 Feb 2017 20:33:37 +1100
Subject: [PATCH] ARM: sun7i: Enable audio codec on A20-OLinuXino-Micro
Message-ID: <20170210093337.28821-1-net147@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A20-OLinuXino-Micro has 3.5 mm sockets for headphone output and
microphone input.

Signed-off-by: Jonathan Liu <net147@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 223fbd9f7c62..3c1680c340b1 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -85,6 +85,10 @@
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
2.11.1
