From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 27 Nov 2017 16:53:11 +0000
Subject: [PATCH 13/13] ARM: dts: imx6qdl-cubox-i: fix node names
In-Reply-To: <20171127165134.GH31757@n2100.armlinux.org.uk>
References: <20171127165134.GH31757@n2100.armlinux.org.uk>
Message-ID: <E1eJMed-0002rt-Cm@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Node names are supposed to be generic, fix the RTC node name.  We
also don't need the alias.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
index 7a3fba776661..ca04ec56d2af 100644
--- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -135,7 +135,7 @@
 
 	status = "okay";
 
-	rtc: pcf8523 at 68 {
+	rtc at 68 {
 		compatible = "nxp,pcf8523";
 		reg = <0x68>;
 	};
-- 
2.7.4
