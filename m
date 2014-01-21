From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 21 Jan 2014 18:13:30 +0200
Subject: [PATCH 2/4] ARM: dts: cm-fx6: add SATA support
In-Reply-To: <1390320812-25100-1-git-send-email-grinberg@compulab.co.il>
References: <1390320812-25100-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <1390320812-25100-3-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable SATA on cm-fx6.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/boot/dts/imx6q-cm-fx6.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/imx6q-cm-fx6.dts
index 94cc6b5..07f90a5 100644
--- a/arch/arm/boot/dts/imx6q-cm-fx6.dts
+++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
@@ -69,3 +69,7 @@
 	pinctrl-0 = <&pinctrl_uart4>;
 	status = "okay";
 };
+
+&sata {
+	status = "okay";
+};
-- 
1.8.3.2
