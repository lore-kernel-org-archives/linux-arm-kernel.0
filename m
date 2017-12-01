From: dinguyen@kernel.org (Dinh Nguyen)
Date: Fri,  1 Dec 2017 11:43:15 -0600
Subject: [PATCH 3/3] arm64: dts: stratix10: enable USB on the devkit
In-Reply-To: <1512150195-31821-1-git-send-email-dinguyen@kernel.org>
References: <1512150195-31821-1-git-send-email-dinguyen@kernel.org>
Message-ID: <1512150195-31821-3-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable USB on the Stratix10 devkit.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index a37c461..0007564 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -97,3 +97,7 @@
 &uart0 {
 	status = "okay";
 };
+
+&usb0 {
+	status = "okay";
+};
-- 
2.7.4
