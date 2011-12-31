From: jason.chen@linaro.org (Jason Chen)
Date: Sat, 31 Dec 2011 14:23:34 +0800
Subject: [PATCH 1/2] ARM: imx6q: add compatible name of iomuxc
Message-ID: <1325312614-22948-1-git-send-email-jason.chen@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jason Chen <jason.chen@linaro.org>
Signed-off-by: Jason Chen <jason.chen@freescale.com>
---
 arch/arm/boot/dts/imx6q.dtsi |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 72b78bb..b3b7609 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -391,6 +391,7 @@
 			};
 
 			iomuxc at 020e0000 {
+				compatible = "fsl,imx6q-iomuxc";
 				reg = <0x020e0000 0x4000>;
 			};
 
-- 
1.7.4.1
