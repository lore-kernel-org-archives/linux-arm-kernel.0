From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Mon, 12 May 2014 18:26:29 +0200
Subject: [PATCH v2 3/4] ARM: at91/dt: define sam9n12ek crystal frequencies
In-Reply-To: <1399911990-5086-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1399911990-5086-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1399911990-5086-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define sam9n12ek's main and slow crystal frequencies.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
Tested-by: Bo Shen <voice.shen@atmel.com>
---
 arch/arm/boot/dts/at91sam9n12ek.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index 924a6a6..64bbe46 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -21,6 +21,14 @@
 		reg = <0x20000000 0x8000000>;
 	};
 
+	slow_xtal {
+		clock-frequency = <32768>;
+	};
+
+	main_xtal {
+		clock-frequency = <16000000>;
+	};
+
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.8.3.2
