From: michal.simek@xilinx.com (Michal Simek)
Date: Thu,  3 Aug 2017 13:36:51 +0200
Subject: [PATCH 5/5] arm64: zynqmp: Add missing mmc aliases in ep108
In-Reply-To: <cover.1501760202.git.michal.simek@xilinx.com>
References: <cover.1501760202.git.michal.simek@xilinx.com>
Message-ID: <f5140f44e9a1784e93e4dcef0c62c663371bf9bd.1501760202.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing mmc aliases.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
index 6a8b4b445531..150e1d1c35d8 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
@@ -20,6 +20,8 @@
 	model = "ZynqMP EP108";
 
 	aliases {
+		mmc0 = &sdhci0;
+		mmc1 = &sdhci1;
 		serial0 = &uart0;
 	};
 
-- 
1.9.1
