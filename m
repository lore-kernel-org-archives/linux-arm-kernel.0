From: scott.branden@broadcom.com (Scott Branden)
Date: Fri, 18 May 2018 08:21:20 -0700
Subject: [PATCH] arm64: dts: specify 1.8V EMMC capabilities for bcm958742k
Message-ID: <1526656880-8795-1-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specify 1.8V EMMC capabilities for bcm958742k board to indicate support
for UHS mode.

Fixes: d4b4aba6be8a ("arm64: dts: Initial DTS files for Broadcom Stingray SOC")
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts b/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts
index eb6f08c..77efa28 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts
+++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts
@@ -43,6 +43,10 @@
 	enet-phy-lane-swap;
 };
 
+&sdio0 {
+	mmc-ddr-1_8v;
+};
+
 &uart2 {
 	status = "okay";
 };
-- 
2.5.0
