From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  9 Dec 2014 12:24:59 +0100
Subject: [PATCH 1/7] ARM: shmobile: genmai dts: Replace status value "ok" by
 "okay"
Message-ID: <1418124305-7445-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While the DT parsing code recognizes "ok" as a valid value for the
"status" property, ePAPR v1.1 doesn't mention it in the list of valid
values.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r7s72100-genmai.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r7s72100-genmai.dts b/arch/arm/boot/dts/r7s72100-genmai.dts
index 1518c5bcca33d8d1..a9da7a89fc4ba65a 100644
--- a/arch/arm/boot/dts/r7s72100-genmai.dts
+++ b/arch/arm/boot/dts/r7s72100-genmai.dts
@@ -45,7 +45,7 @@
 };
 
 &mtu2 {
-	status = "ok";
+	status = "okay";
 };
 
 &i2c2 {
-- 
1.9.1
