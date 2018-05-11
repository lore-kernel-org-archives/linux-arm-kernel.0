From: yinbo.zhu@nxp.com (Yinbo Zhu)
Date: Fri, 11 May 2018 11:35:29 +0800
Subject: [PATCH 8/9] arm64: dts: ls1046a: Add the identify of the platform to
 support to set rcpm bit
In-Reply-To: <20180511033530.7931-1-yinbo.zhu@nxp.com>
References: <20180511033530.7931-1-yinbo.zhu@nxp.com>
Message-ID: <20180511033530.7931-8-yinbo.zhu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhang Ying-22455 <ying.zhang22455@nxp.com>

Add the identify of the platform to support set the rcpm with
big-endian or little-endian.

Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 3e09bcb..1ce1153 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -575,7 +575,7 @@
 		};
 
 		ftm0: ftm0 at 29d0000 {
-			compatible = "fsl,ftm-alarm";
+			compatible = "fsl,ls1046a-ftm";
 			reg = <0x0 0x29d0000 0x0 0x10000>,
 			      <0x0 0x1ee2140 0x0 0x4>;
 			reg-names = "ftm", "FlexTimer1";
-- 
1.7.1
