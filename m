From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 15 Sep 2014 16:01:53 +0200
Subject: [PATCH v3 9/9] ARM: dts: berlin: enable the Ethernet port on the BG2Q
 DMP
In-Reply-To: <1410789713-15341-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1410789713-15341-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1410789713-15341-10-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the Ethernet port on the Marvell Berlin2Q DMP board.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
index a357ce02a64e..ea1f99b8eed6 100644
--- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
+++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
@@ -45,3 +45,7 @@
 &uart0 {
 	status = "okay";
 };
+
+&eth0 {
+	status = "okay";
+};
-- 
1.9.1
