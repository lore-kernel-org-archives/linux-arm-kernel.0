From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 19 Jul 2013 14:58:33 +0100
Subject: [PATCH 02/22] ARM: ux500: Remove '0x's from nomadik stn8815 DTS file
In-Reply-To: <1374242333-6852-1-git-send-email-lee.jones@linaro.org>
References: <1374242333-6852-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1374242333-6852-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index a3acfa7..c2ee51e 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -742,14 +742,14 @@
 		#size-cells = <1>;
 		ranges;
 
-		vica: intc at 0x10140000 {
+		vica: intc at 10140000 {
 			compatible = "arm,versatile-vic";
 			interrupt-controller;
 			#interrupt-cells = <1>;
 			reg = <0x10140000 0x20>;
 		};
 
-		vicb: intc at 0x10140020 {
+		vicb: intc at 10140020 {
 			compatible = "arm,versatile-vic";
 			interrupt-controller;
 			#interrupt-cells = <1>;
-- 
1.8.1.2
