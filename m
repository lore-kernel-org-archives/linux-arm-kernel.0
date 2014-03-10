From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 10 Mar 2014 12:26:59 +0100
Subject: [PATCH V2 4/5] ARM: shmobile: koelsch: make i2c2-pfc node unique
In-Reply-To: <1394450820-8158-1-git-send-email-wsa@the-dreams.de>
References: <1394450820-8158-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1394450820-8158-4-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

This node should have a unique name so it can be distinguished when
other i2c busses are added later.

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

Changes since V1: added ack

 arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index e24fed9c0462..5e90f18db1fb 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -199,7 +199,7 @@
 	pinctrl-0 = <&du_pins &scif0_pins &scif1_pins>;
 	pinctrl-names = "default";
 
-	i2c2_pins: i2c {
+	i2c2_pins: i2c2 {
 		renesas,groups = "i2c2";
 		renesas,function = "i2c2";
 	};
-- 
1.9.0
