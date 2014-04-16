From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Wed, 16 Apr 2014 14:40:11 +0200
Subject: [PATCH 4/4] ARM: dts: berlin: enable SD card reader and eMMC for the
 BG2Q DMP
In-Reply-To: <1397652011-21284-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1397652011-21284-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1397652011-21284-5-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the SD Card reader and the internal eMMC on the Berlin BG2Q DMP
using two of the SDHCI nodes of the Berlin BG2Q.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
index 2da9c41e29d8..671ed4d055ed 100644
--- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
+++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
@@ -26,3 +26,11 @@
 &uart0 {
 	status = "okay";
 };
+
+&sdhci1 {
+	status = "okay";
+};
+
+&sdhci2 {
+	status = "okay";
+};
-- 
1.8.3.2
