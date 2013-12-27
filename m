From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 27 Dec 2013 15:59:58 +0100
Subject: [PATCH v2 4/5] ARM: dts: sun5i: Add rtp controller node
In-Reply-To: <1388156399-29677-1-git-send-email-hdegoede@redhat.com>
References: <1388156399-29677-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1388156399-29677-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 6 ++++++
 arch/arm/boot/dts/sun5i-a13.dtsi  | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 948eb10..34dd303 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -409,6 +409,12 @@
 			reg = <0x01c23800 0x10>;
 		};
 
+		rtp: rtp at 01c25000 {
+			compatible = "allwinner,sun4i-ts";
+			reg = <0x01c25000 0x100>;
+			interrupts = <29>;
+		};
+
 		uart0: serial at 01c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index ca15672..264cfa4 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -367,6 +367,12 @@
 			reg = <0x01c23800 0x10>;
 		};
 
+		rtp: rtp at 01c25000 {
+			compatible = "allwinner,sun4i-ts";
+			reg = <0x01c25000 0x100>;
+			interrupts = <29>;
+		};
+
 		uart1: serial at 01c28400 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28400 0x400>;
-- 
1.8.4.2
