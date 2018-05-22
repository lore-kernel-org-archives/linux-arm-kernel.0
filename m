From: scott.branden@broadcom.com (Scott Branden)
Date: Tue, 22 May 2018 10:01:39 -0700
Subject: [PATCH] arm64: dts: specify 1.8V EMMC capabilities for bcm958742t
Message-ID: <1527008499-4120-1-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specify 1.8V EMMC capabilities for bcm958742t board to indicate support
for UHS mode.

Fixes: d4b4aba6be8a ("arm64: dts: Initial DTS files for Broadcom Stingray SOC")
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts b/arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts
index 6a4d19e..dd9de6b 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts
+++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts
@@ -44,3 +44,7 @@
 &gphy0 {
 	enet-phy-lane-swap;
 };
+
+&sdio0 {
+	mmc-ddr-1_8v;
+};
-- 
2.5.0
