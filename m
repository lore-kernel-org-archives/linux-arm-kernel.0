From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 29 Oct 2014 12:33:56 +0100
Subject: [PATCH 2/2] ARM: dts: socfpga: Add l3nic node
In-Reply-To: <1414582436-12772-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1414582436-12772-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1414582436-12772-2-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/socfpga.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 58c4a2eabd2d..4cdcd5f9772d 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -654,6 +654,11 @@
 			arm,data-latency = <2 1 1>;
 		};
 
+		l3regs: gpv at ff800000 {
+			compatible = "altr,l3-nic";
+			reg = <0xff800000 0x100000>;
+		};
+
 		mmc: dwmmc0 at ff704000 {
 			compatible = "altr,socfpga-dw-mshc";
 			reg = <0xff704000 0x1000>;
-- 
2.1.1
