From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 23 Sep 2014 14:15:36 +0200
Subject: [PATCH v4 9/9] ARM: dts: berlin: enable the Ethernet port on the BG2Q
 DMP
In-Reply-To: <1411474536-22626-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1411474536-22626-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1411474536-22626-10-git-send-email-antoine.tenart@free-electrons.com>
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
