From: B38611@freescale.com (Fugang Duan)
Date: Tue, 3 Sep 2013 12:26:22 +0800
Subject: [PATCH v2 1/4] ARM: dts: add iomuxc-gpr device node for imx6sl
In-Reply-To: <1378182385-9205-1-git-send-email-B38611@freescale.com>
References: <1378182385-9205-1-git-send-email-B38611@freescale.com>
Message-ID: <1378182385-9205-2-git-send-email-B38611@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add iomuxc gpr device node for imx6sl.

Signed-off-by: Fugang Duan  <B38611@freescale.com>
---
 arch/arm/boot/dts/imx6sl.dtsi |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index c5e5da0..abd1eb9 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -504,6 +504,11 @@
 				interrupts = <0 89 0x04>;
 			};
 
+			gpr: iomuxc-gpr at 020e0000 {
+				compatible = "fsl,imx6sl-iomuxc-gpr", "syscon";
+				reg = <0x020e0000 0x38>;
+			};
+
 			iomuxc: iomuxc at 020e0000 {
 				compatible = "fsl,imx6sl-iomuxc";
 				reg = <0x020e0000 0x4000>;
-- 
1.7.1
