From: yegorslists@googlemail.com (yegorslists at googlemail.com)
Date: Wed, 19 Oct 2016 09:09:03 +0200
Subject: [PATCH] ARM: dts: am335x-baltos-ir5221: use both musb channels in
 host mode
Message-ID: <1476860943-30994-1-git-send-email-yegorslists@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yegor Yefremov <yegorslists@googlemail.com>

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 arch/arm/boot/dts/am335x-baltos-ir5221.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-baltos-ir5221.dts b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
index d0faa7b..f599350 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir5221.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
@@ -114,7 +114,7 @@
 
 &usb1 {
 	status = "okay";
-	dr_mode = "otg";
+	dr_mode = "host";
 };
 
 &cpsw_emac0 {
-- 
2.1.4
