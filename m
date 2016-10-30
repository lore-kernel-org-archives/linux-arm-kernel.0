From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 30 Oct 2016 17:22:19 +0000
Subject: =?UTF-8?q?=5BPATCH=20V2=202/2=5D=20ARM=3A=20dts=3A=20bcm283x=3A=20fix=20typo=20in=20mailbox=20address?=
In-Reply-To: <6b13e96d-78d1-fcab-4273-803310ae4da6@suse.de>
References: <6b13e96d-78d1-fcab-4273-803310ae4da6@suse.de>
Message-ID: <1477848139-32267-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The address of the mailbox node in the bcm283x.dtsi also has a typo.
So fix it accordingly.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Andreas F?rber <afaerber@suse.de>
Fixes: 05b682b7a3b2 ("ARM: bcm2835: dt: Add the mailbox to the device tree")
---
Changes in V2:
  * fixed commit message as reported by Andreas

 arch/arm/boot/dts/bcm283x.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 46d46d8..74dd21b 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -104,7 +104,7 @@
 			reg = <0x7e104000 0x10>;
 		};
 
-		mailbox: mailbox at 7e00b800 {
+		mailbox: mailbox at 7e00b880 {
 			compatible = "brcm,bcm2835-mbox";
 			reg = <0x7e00b880 0x40>;
 			interrupts = <0 1>;
-- 
1.7.9.5
