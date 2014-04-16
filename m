From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 16 Apr 2014 09:43:41 +0100
Subject: [PATCH RFC 4/5] ARM: cubox-i: add eSATA DT configuration
In-Reply-To: <20140416084227.GD24070@n2100.arm.linux.org.uk>
References: <20140416084227.GD24070@n2100.arm.linux.org.uk>
Message-ID: <E1WaLRV-0002yT-3o@rmk-PC.arm.linux.org.uk>
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
