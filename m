From: dt.tangr@gmail.com (dt.tangr at gmail.com)
Date: Wed,  4 Dec 2013 20:20:08 +1100
Subject: [PATCH 2/2] arm: nspire: modify device tree to use the nspire-usb
 driver
In-Reply-To: <1386148808-15065-1-git-send-email-dt.tangr@gmail.com>
References: <1386148808-15065-1-git-send-email-dt.tangr@gmail.com>
Message-ID: <1386148808-15065-2-git-send-email-dt.tangr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Tang <dt.tangr@gmail.com>

This patch adds the needed compatible key to the device tree for TI-Nspires.

Signed-off-by: Daniel Tang <dt.tangr@gmail.com>
---
 arch/arm/boot/dts/nspire.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/nspire.dtsi b/arch/arm/boot/dts/nspire.dtsi
index a22ffe6..baf7153 100644
--- a/arch/arm/boot/dts/nspire.dtsi
+++ b/arch/arm/boot/dts/nspire.dtsi
@@ -65,6 +65,7 @@
 		};
 
 		usb0: usb at B0000000 {
+			compatible = "lsi,nspire-usb";
 			reg = <0xB0000000 0x1000>;
 			interrupts = <8>;
 		};
-- 
1.7.10.4
