From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 26 Jul 2012 11:28:43 +0100
Subject: [PATCH 10/21] ARM: ux500: Add ux500 PCM to DB8500 Device Tree
In-Reply-To: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1343298534-13611-11-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nothing special here. We're only providing a compatible string
to ensure the driver is probed using a Device Tree boot.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index 5a72be6..b9d4405 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -591,6 +591,10 @@
 			status = "disabled";
 		};
 
+		pcm: ux500-pcm {
+			compatible = "stericsson,ux500-pcm";
+		};
+
 		msp0: msp at 80123000 {
 			compatible = "stericsson,ux500-msp-i2s";
 			reg = <0x80123000 0x1000>;
-- 
1.7.9.5
