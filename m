From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Wed, 11 Mar 2015 16:06:01 +0100
Subject: [PATCH 2/2] ARM: dts: imx28-apf28dev: add wakeup function to user
 button
In-Reply-To: <1426086361-32933-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1426086361-32933-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <1426086361-32933-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 arch/arm/boot/dts/imx28-apf28dev.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/imx28-apf28dev.dts
index 1e72b0d..7ac4f1a 100644
--- a/arch/arm/boot/dts/imx28-apf28dev.dts
+++ b/arch/arm/boot/dts/imx28-apf28dev.dts
@@ -225,6 +225,7 @@
 			label = "User button";
 			gpios = <&gpio0 17 GPIO_ACTIVE_LOW>;
 			linux,code = <0x100>;
+			gpio-key,wakeup;
 		};
 	};
 };
-- 
2.0.5
