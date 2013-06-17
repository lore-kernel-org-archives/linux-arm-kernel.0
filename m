From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 17 Jun 2013 14:38:30 +0200
Subject: [PATCH 5/5] ARM: at91: at91rm9200: set default mmc0 pinctrl-names
In-Reply-To: <1371472710-18535-1-git-send-email-plagnioj@jcrosoft.com>
References: <20130617123645.GA21034@game.jcrosoft.org>
 <1371472710-18535-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1371472710-18535-5-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91rm9200.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index 1fc645e..8bc87e5 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -116,6 +116,7 @@
 				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				pinctrl-names = "default";
 				status = "disabled";
 			};
 
-- 
1.7.10.4
