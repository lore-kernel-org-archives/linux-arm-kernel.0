From: jaz@semihalf.com (Grzegorz Jaszczyk)
Date: Thu,  4 Aug 2016 12:14:06 +0200
Subject: [PATCH v2 03/17] ARM: dts: mvebu: a385-db-ap: enable USB (orion-ehci)
 port
In-Reply-To: <1470305660-6601-1-git-send-email-jaz@semihalf.com>
References: <1470305660-6601-1-git-send-email-jaz@semihalf.com>
Message-ID: <1470305660-6601-4-git-send-email-jaz@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 385 Access Point Development board contains USB port, which can
be handled by existing orion-ehci driver.

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-385-db-ap.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/armada-385-db-ap.dts b/arch/arm/boot/dts/armada-385-db-ap.dts
index 2d3fd6e..a18f516 100644
--- a/arch/arm/boot/dts/armada-385-db-ap.dts
+++ b/arch/arm/boot/dts/armada-385-db-ap.dts
@@ -155,6 +155,10 @@
 				bm,pool-short = <3>;
 			};
 
+			usb at 58000 {
+				status = "okay";
+			};
+
 			/* CON4 */
 			ethernet at 70000 {
 				pinctrl-names = "default";
-- 
1.8.3.1
