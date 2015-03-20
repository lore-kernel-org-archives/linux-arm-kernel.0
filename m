From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 20 Mar 2015 14:36:05 +0100
Subject: [PATCH 4/4] ARM: berlin: enable the ADC on the BG2Q DMP
In-Reply-To: <1426858565-31053-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1426858565-31053-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1426858565-31053-5-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An ADC node is now available in the BG2Q SoC device tree. Enable it on
the BG2Q DMP board.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
index a98ac1bd8f65..a6de0039e5bc 100644
--- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
+++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
@@ -112,3 +112,7 @@
 &sata_phy {
 	status = "okay";
 };
+
+&adc {
+	status = "okay";
+};
-- 
2.3.3
