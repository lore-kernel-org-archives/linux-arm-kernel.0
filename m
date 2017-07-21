From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Fri, 21 Jul 2017 13:29:49 +0200
Subject: [PATCH v2 4/4] ARM: dts: tango4: Add RGMII RX and TX clock delays
In-Reply-To: <2617d673-ef81-5e7f-4730-ed3aa3f1c2c6@sigmadesigns.com>
References: <2617d673-ef81-5e7f-4730-ed3aa3f1c2c6@sigmadesigns.com>
Message-ID: <5ee7b36f-9c46-d36e-08c6-2aa52a77f559@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RX and TX clock delays are required.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 arch/arm/boot/dts/tango4-vantage-1172.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tango4-vantage-1172.dts b/arch/arm/boot/dts/tango4-vantage-1172.dts
index 86d8df98802f..13bcc460bcb2 100644
--- a/arch/arm/boot/dts/tango4-vantage-1172.dts
+++ b/arch/arm/boot/dts/tango4-vantage-1172.dts
@@ -22,7 +22,7 @@
 };
 
 &eth0 {
-	phy-connection-type = "rgmii";
+	phy-connection-type = "rgmii-id";
 	phy-handle = <&eth0_phy>;
 	#address-cells = <1>;
 	#size-cells = <0>;
-- 
2.11.0
