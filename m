From: jon.mason@broadcom.com (Jon Mason)
Date: Thu, 17 Nov 2016 18:25:02 -0500
Subject: [PATCH 1/2] arm64: dts: NS2: enable sdio1
In-Reply-To: <1479425103-2119-1-git-send-email-jon.mason@broadcom.com>
References: <1479425103-2119-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1479425103-2119-2-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable sdio1 in the Northstar2 SVK device tree file

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2-svk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
index 07c69a3e..de8d379 100644
--- a/arch/arm64/boot/dts/broadcom/ns2-svk.dts
+++ b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
@@ -161,6 +161,10 @@
 	status = "ok";
 };
 
+&sdio1 {
+	status = "ok";
+};
+
 &nand {
 	nandcs at 0 {
 		compatible = "brcm,nandcs";
-- 
2.7.4
