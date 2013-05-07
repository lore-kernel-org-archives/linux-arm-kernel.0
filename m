From: b32955@freescale.com (Huang Shijie)
Date: Tue, 7 May 2013 15:39:20 +0800
Subject: [PATCH 3/3] ARM: dts: enable the gpmi-nand for imx6q{dl}-sabreauto
 boards
In-Reply-To: <1367912360-3283-1-git-send-email-b32955@freescale.com>
References: <1367912360-3283-1-git-send-email-b32955@freescale.com>
Message-ID: <1367912360-3283-3-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable the gpmi-nand for imx6q-sabreauto and imx6qdl-sabreauto boards.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 4d237cf..7b561fb 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -23,6 +23,12 @@
 	status = "okay";
 };
 
+&gpmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpmi_nand_1>;
+	status = "okay";
+};
+
 &uart4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart4_1>;
-- 
1.7.1
