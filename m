From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 17 Jul 2017 22:25:02 +0200
Subject: [PATCH 3/5] ARM: dts: imx6: RDU2: Add Switch EEPROM
In-Reply-To: <1500323104-11583-1-git-send-email-andrew@lunn.ch>
References: <1500323104-11583-1-git-send-email-andrew@lunn.ch>
Message-ID: <1500323104-11583-4-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell switch has an EEPROM connected to it. List the size in DT,
in order to enable access to it via ethtool.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index add53277379d..d67bf81524a2 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -636,6 +636,7 @@
 			#size-cells = <0>;
 			reg = <0>;
 			dsa,member = <0 0>;
+			eeprom-length = <512>;
 
 			ports {
 				#address-cells = <1>;
-- 
2.13.2
