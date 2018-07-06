From: guodong.xu@linaro.org (Guodong Xu)
Date: Fri,  6 Jul 2018 11:55:20 +0800
Subject: [PATCH v2 3/4] arm64: dts: hi3660: update property name hisilicon,
 dma-min-chan
In-Reply-To: <20180706035521.13736-1-guodong.xu@linaro.org>
References: <20180706035521.13736-1-guodong.xu@linaro.org>
Message-ID: <20180706035521.13736-4-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update property name dma-min-chan to "hisilicon,dma-min-chan"

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 8d477dcbfa58..0cec26976eb6 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -537,7 +537,7 @@
 			#dma-cells = <1>;
 			dma-channels = <16>;
 			dma-requests = <32>;
-			dma-min-chan = <1>;
+			hisilicon,dma-min-chan = <1>;
 			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_DMAC>;
 			dma-no-cci;
-- 
2.17.1
