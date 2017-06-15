From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 15 Jun 2017 10:01:50 +0200
Subject: [PATCH] arm64: dts: marvell: enable the cpm crypto engine on the mcbin
Message-ID: <20170615080150.27534-1-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the cpm crypto engine on the mcbin.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---

Hi Gregory,

This patch applies on top of today's mvebu/dt64 branch.

Thanks!
Antoine

 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
index fe56efcfcefe..2556c8268b40 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
@@ -176,3 +176,7 @@
 	usb-phy = <&usb3h0_phy>;
 	status = "okay";
 };
+
+&cpm_crypto {
+	status = "okay";
+};
-- 
2.9.4
