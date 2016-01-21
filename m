From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 21 Jan 2016 18:38:42 +0000
Subject: [PATCH] arm64: dts: apq8016-sbc: Add aliases to spi device.
Message-ID: <1453401522-27291-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds aliases to spi device so that it can get proper bus
number rather than a random number.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index db17c5d..6eb096e 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -24,6 +24,8 @@
 		i2c0	= &blsp_i2c2;
 		i2c1	= &blsp_i2c6;
 		i2c3	= &blsp_i2c4;
+		spi0	= &blsp_spi5;
+		spi1	= &blsp_spi3;
 	};
 
 	chosen {
-- 
1.9.1
