From: lho@apm.com (Loc Ho)
Date: Tue, 19 Jan 2016 19:27:43 -0700
Subject: [PATCH v2 3/3] arm64: Update Merlin DT PCP PLL clock node for v2
 hardware
In-Reply-To: <1453256863-15092-1-git-send-email-lho@apm.com>
References: <1453256863-15092-1-git-send-email-lho@apm.com>
Message-ID: <1453256863-15092-4-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update Merlin DT PCP PLL clock node to reflect compatible
string change to reflect v2 hardware.

Signed-off-by: Loc Ho <lho@apm.com>
---
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
index 5d87a3d..83d293e 100644
--- a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
@@ -224,7 +224,7 @@
 			};
 
 			socpll: socpll at 17000120 {
-				compatible = "apm,xgene-socpll-clock";
+				compatible = "apm,xgene-socpll-v2-clock";
 				#clock-cells = <1>;
 				clocks = <&refclk 0>;
 				reg = <0x0 0x17000120 0x0 0x1000>;
-- 
1.7.1
