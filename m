From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 11 Dec 2017 16:57:42 +0000
Subject: [PATCH 05/20] ARM: dts: imx6*-hummingboard2: add Broadcom Wi-Fi
 include
In-Reply-To: <20171211165631.GW10595@n2100.armlinux.org.uk>
References: <20171211165631.GW10595@n2100.armlinux.org.uk>
Message-ID: <E1eOROg-0000HB-Ur@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Broadcom Wi-Fi was moved out to a separate include file.  Add the
include.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/imx6dl-hummingboard2.dts | 1 +
 arch/arm/boot/dts/imx6q-hummingboard2.dts  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-hummingboard2.dts b/arch/arm/boot/dts/imx6dl-hummingboard2.dts
index 30e042822ec6..99b6cce13175 100644
--- a/arch/arm/boot/dts/imx6dl-hummingboard2.dts
+++ b/arch/arm/boot/dts/imx6dl-hummingboard2.dts
@@ -43,6 +43,7 @@
 
 #include "imx6dl.dtsi"
 #include "imx6qdl-sr-som.dtsi"
+#include "imx6qdl-sr-som-brcm.dtsi"
 #include "imx6qdl-hummingboard2.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/imx6q-hummingboard2.dts b/arch/arm/boot/dts/imx6q-hummingboard2.dts
index 8dcad5668c17..fab388a0f673 100644
--- a/arch/arm/boot/dts/imx6q-hummingboard2.dts
+++ b/arch/arm/boot/dts/imx6q-hummingboard2.dts
@@ -43,6 +43,7 @@
 
 #include "imx6q.dtsi"
 #include "imx6qdl-sr-som.dtsi"
+#include "imx6qdl-sr-som-brcm.dtsi"
 #include "imx6qdl-hummingboard2.dtsi"
 
 / {
-- 
2.7.4
