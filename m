From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 26 Oct 2016 18:14:00 +0000
Subject: [PATCH 2/2] ARM: dts: bcm283x: fix typo in mailbox address
In-Reply-To: <1477505640-26658-1-git-send-email-stefan.wahren@i2se.com>
References: <1477505640-26658-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1477505640-26658-2-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The address of the mailbox node in the bcm283x.dts has also a typo.
So fix it accordingly.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Fixes: 05b682b7a3b2 ("ARM: bcm2835: dt: Add the mailbox to the device tree")
---
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
