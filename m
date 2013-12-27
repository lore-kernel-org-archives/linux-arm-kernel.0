From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 27 Dec 2013 15:59:57 +0100
Subject: [PATCH v2 3/5] ARM: dts: sun4i: Add rtp controller node
In-Reply-To: <1388156399-29677-1-git-send-email-hdegoede@redhat.com>
References: <1388156399-29677-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1388156399-29677-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index de1dd73..502f3e2 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -452,6 +452,12 @@
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
-- 
1.8.4.2
