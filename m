From: jaz@semihalf.com (Grzegorz Jaszczyk)
Date: Thu, 21 Jul 2016 14:44:00 +0200
Subject: [PATCH 04/18] ARM: mvebu: a385-db-ap: enable USB (orion-ehci) port
In-Reply-To: <1469105055-25181-1-git-send-email-jaz@semihalf.com>
References: <1469105055-25181-1-git-send-email-jaz@semihalf.com>
Message-ID: <1469105055-25181-5-git-send-email-jaz@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
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
