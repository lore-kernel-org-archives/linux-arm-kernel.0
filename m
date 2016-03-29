From: patrick@puiterwijk.org (Patrick Uiterwijk)
Date: Tue, 29 Mar 2016 13:56:53 +0000
Subject: [PATCH 2/2] ARM: mvebu: Correct unit address for linksys
In-Reply-To: <1459259813-5278-1-git-send-email-patrick@puiterwijk.org>
References: <1459259813-5278-1-git-send-email-patrick@puiterwijk.org>
Message-ID: <1459259813-5278-3-git-send-email-patrick@puiterwijk.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB2 port for Armada 38x is defined to be at 58000, not at
50000.

Signed-off-by: Patrick Uiterwijk <patrick@puiterwijk.org>
---
 arch/arm/boot/dts/armada-385-linksys.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-385-linksys.dtsi b/arch/arm/boot/dts/armada-385-linksys.dtsi
index b328d94..94b8b0b 100644
--- a/arch/arm/boot/dts/armada-385-linksys.dtsi
+++ b/arch/arm/boot/dts/armada-385-linksys.dtsi
@@ -117,7 +117,7 @@
 			};
 
 			/* USB part of the eSATA/USB 2.0 port */
-			ehci at 50000 {
+			ehci at 58000 {
 				status = "okay";
 			};
 
-- 
2.7.4
