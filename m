From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Wed, 30 Dec 2015 15:39:01 +0200
Subject: [PATCH 2/6] ARM: dts: am57xx: cl-som-am57x: set HOST mode for USB2
In-Reply-To: <1451482745-1820-1-git-send-email-lifshitz@compulab.co.il>
References: <1451482745-1820-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1451482745-1820-3-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setup USB2 to act in "HOST" mode by default.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index c538826..513ec62 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -588,7 +588,7 @@
 };
 
 &usb2 {
-	dr_mode = "peripheral";
+	dr_mode = "host";
 };
 
 &mcasp3 {
-- 
1.9.1
