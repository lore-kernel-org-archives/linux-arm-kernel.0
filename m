From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  9 Jul 2014 17:06:46 +0200
Subject: [PATCHv3 18/34] ARM: at91/dt: aks-cdu: define slow crytal frequency
In-Reply-To: <1404918422-7562-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1404918422-7562-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1404918422-7562-19-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define AK signal CDU slow crystal frequency

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/aks-cdu.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aks-cdu.dts b/arch/arm/boot/dts/aks-cdu.dts
index 54cb5cf8604a..d9c50fbb49d2 100644
--- a/arch/arm/boot/dts/aks-cdu.dts
+++ b/arch/arm/boot/dts/aks-cdu.dts
@@ -16,6 +16,12 @@
 		bootargs = "console=ttyS0,115200 ubi.mtd=4 root=ubi0:rootfs rootfstype=ubifs";
 	};
 
+	clocks {
+		slow_xtal {
+			clock-frequency = <32768>;
+		};
+	};
+
 	ahb {
 		apb {
 			usart0: serial at fffb0000 {
-- 
1.9.1
