From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:43:27 +0100
Subject: [PATCH 141/222] ARM: cubox-i: add eSATA DT configuration
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeXP-0007Mh-Nn@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/imx6q-cubox-i.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-cubox-i.dts b/arch/arm/boot/dts/imx6q-cubox-i.dts
index bc5f31e3e892..941365d7ee65 100644
--- a/arch/arm/boot/dts/imx6q-cubox-i.dts
+++ b/arch/arm/boot/dts/imx6q-cubox-i.dts
@@ -13,4 +13,7 @@
 
 &sata {
 	status = "okay";
+	fsl,transmit-level-mV = <1104>;
+	fsl,transmit-boost-mdB = <0>;
+	fsl,transmit-atten-16ths = <9>;
 };
-- 
1.8.3.1
