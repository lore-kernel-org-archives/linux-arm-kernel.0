From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 23 Jun 2015 16:51:44 -0700
Subject: [PATCH] ARM: BCM5301X: Enable UART0 for SmartRG SR-400AC
Message-ID: <1435103504-28592-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the use of UART0 by overriding its default status property.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
index d6a033b97c70..64a5e8ab65e0 100644
--- a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
+++ b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
@@ -118,3 +118,7 @@
 		};
 	};
 };
+
+&uart0 {
+	status = "okay";
+};
-- 
2.1.0
