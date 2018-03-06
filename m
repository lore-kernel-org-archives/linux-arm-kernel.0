From: dinguyen@kernel.org (Dinh Nguyen)
Date: Tue,  6 Mar 2018 08:37:14 -0600
Subject: [PATCH] arm64: dts: stratix10: enable watchdog timer on the S10 devkit
Message-ID: <1520347034-10445-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enables the watchdog0 timer on the Stratix10 devkit.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index cf3b519..95f8669 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -145,3 +145,7 @@
 		reg = <0x68>;
 	};
 };
+
+&watchdog0 {
+	status = "okay";
+};
-- 
2.7.4
