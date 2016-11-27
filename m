From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 27 Nov 2016 20:54:44 +0100
Subject: [PATCH] ARM: dts: vf610-zii-dev-rev-b: Add missing newline
Message-ID: <1480276484-5482-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Found while reviewing Marvell dsa bindings usage.

Fixes: f283745b3caf ("arm: vf610: zii devel b: Add support for switch interrupts")
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
index 7ea617e47fe4..958b4c42d320 100644
--- a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
+++ b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
@@ -153,7 +153,8 @@
 					switch0phy1: switch1phy0 at 1 {
 						reg = <1>;
 						interrupt-parent = <&switch0>;
-						interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;					};
+						interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
+					};
 					switch0phy2: switch1phy0 at 2 {
 						reg = <2>;
 						interrupt-parent = <&switch0>;
-- 
2.6.6
