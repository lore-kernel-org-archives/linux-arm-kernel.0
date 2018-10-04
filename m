From: dinguyen@kernel.org (Dinh Nguyen)
Date: Thu,  4 Oct 2018 09:51:48 -0500
Subject: [PATCHv2] arm64: dts: stratix10: add ethernet aliases
Message-ID: <1538664708-11810-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ethernet<n> alias for all gmacs on the devkit.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v2: move ethernet aliases to board file
---
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 53cf195..3d0db30 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -21,6 +21,9 @@
 
 	aliases {
 		serial0 = &uart0;
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+		ethernet2 = &gmac2;
 	};
 
 	chosen {
-- 
2.7.4
