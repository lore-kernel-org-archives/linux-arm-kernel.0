From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 23 Feb 2016 14:15:08 +0000
Subject: [PATCH 12/12] ARM: dts: ifc6410: add correct aliases to the i2c and
 spi bus
In-Reply-To: <1456236639-1379-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1456236639-1379-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1456236908-2927-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds correct aliases to spi and i2c buses so that they get
correct matching bus numbers.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index 6a43b0b..8032686 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -9,6 +9,11 @@
 	aliases {
 		serial0 = &gsbi7_serial;
 		serial1 = &gsbi6_serial;
+		i2c0 = &gsbi1_i2c;
+		i2c1 = &gsbi2_i2c;
+		i2c2 = &gsbi3_i2c;
+		i2c3 = &gsbi4_i2c;
+		spi0 = &gsbi5_spi;
 	};
 
 	chosen {
-- 
1.9.1
