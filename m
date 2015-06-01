From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Mon, 1 Jun 2015 10:51:05 +0530
Subject: [PATCH V2 1/3] ARM: dts: colibri-vf: Add pinmux for UART_0 aka UART_A
 RTS/CTS pins
In-Reply-To: <1433136067-20644-1-git-send-email-bhuvanchandra.dv@toradex.com>
References: <1433136067-20644-1-git-send-email-bhuvanchandra.dv@toradex.com>
Message-ID: <1433136067-20644-2-git-send-email-bhuvanchandra.dv@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
---
 arch/arm/boot/dts/vf-colibri.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
index 68ca125..ad6c5ca 100644
--- a/arch/arm/boot/dts/vf-colibri.dtsi
+++ b/arch/arm/boot/dts/vf-colibri.dtsi
@@ -174,6 +174,8 @@
 			fsl,pins = <
 				VF610_PAD_PTB10__UART0_TX		0x21a2
 				VF610_PAD_PTB11__UART0_RX		0x21a1
+				VF610_PAD_PTB12__UART0_RTS		0x21a2
+				VF610_PAD_PTB13__UART0_CTS		0x21a1
 			>;
 		};
 
-- 
2.1.0
