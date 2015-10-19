From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 19 Oct 2015 16:49:48 +0800
Subject: [PATCH 7/8] arm: dts: berlin: enable wdt0 on the Marvell BG2Q DMP
In-Reply-To: <1445244589-4838-1-git-send-email-jszhang@marvell.com>
References: <1445244589-4838-1-git-send-email-jszhang@marvell.com>
Message-ID: <1445244589-4838-8-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable wdt0 on the Marvell BG2Q DMP board to make use of the watchdog
functionality.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
index 0fa8f1e..e60f53a 100644
--- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
+++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
@@ -139,3 +139,7 @@
 &sata_phy {
 	status = "okay";
 };
+
+&wdt0 {
+	status = "okay";
+};
-- 
2.6.1
