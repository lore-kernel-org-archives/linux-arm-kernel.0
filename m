From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Sep 2017 23:16:54 +0200
Subject: [PATCH 3/4] ARM: dts: Update Integrator/AP PCI v3 compatible
In-Reply-To: <20170927211655.3687-1-linus.walleij@linaro.org>
References: <20170927211655.3687-1-linus.walleij@linaro.org>
Message-ID: <20170927211655.3687-4-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To make a stand-alone PCI driver for the V3 Semiconductor PCI bridge,
we need a proper compatible indicating that we are integrated on the
Integrator/AP platform. Add this.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/integratorap.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/integratorap.dts b/arch/arm/boot/dts/integratorap.dts
index ecca38b43f83..546278269ebd 100644
--- a/arch/arm/boot/dts/integratorap.dts
+++ b/arch/arm/boot/dts/integratorap.dts
@@ -153,7 +153,7 @@
 	};
 
 	pci: pciv3 at 62000000 {
-		compatible = "v3,v360epc-pci";
+		compatible = "arm,integrator-ap-pci", "v3,v360epc-pci";
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-- 
2.13.5
