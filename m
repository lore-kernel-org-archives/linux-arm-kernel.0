From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Sep 2013 13:14:02 +0100
Subject: [PATCH 05/41] ARM: ux500: Supply the DMA clock lookup to the DBX500 DT
In-Reply-To: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
References: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1379506478-16625-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 2c64c85..0bb8ed7 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -229,6 +229,8 @@
 
 			#dma-cells = <3>;
 			memcpy-channels = <56 57 58 59 60>;
+
+			clocks = <&prcmu_clk PRCMU_DMACLK>;
 		};
 
 		prcmu: prcmu at 80157000 {
-- 
1.8.1.2
