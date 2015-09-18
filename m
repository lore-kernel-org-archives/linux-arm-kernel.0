From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 18 Sep 2015 13:30:38 +0100
Subject: [PATCH 02/14] ARM: dts: ifc6410: remove unnecessary eeprom label
In-Reply-To: <1442579371-19822-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1442579371-19822-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1442579438-19910-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes unnecessary eeprom label, which is not used
anywhere in the board file.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index b701f33..2ad2ab8 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -130,7 +130,7 @@
 				status = "okay";
 				clock-frequency = <200000>;
 
-				eeprom: eeprom at 52 {
+				eeprom at 52 {
 					compatible = "atmel,24c128";
 					reg = <0x52>;
 					pagesize = <32>;
-- 
1.9.1
