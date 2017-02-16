From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Thu, 16 Feb 2017 19:15:29 +0100
Subject: [PATCH 1/4] ARM: dts: da850-evm: fix whitespace errors
In-Reply-To: <1487268932-6469-1-git-send-email-bgolaszewski@baylibre.com>
References: <1487268932-6469-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1487268932-6469-2-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The da850-evm dts file contains whitespace errors in the vpif node.

This patch fixes them.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850-evm.dts | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 8c5671c..dece981 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -302,14 +302,14 @@
 	/* VPIF capture port */
 	port {
 		vpif_ch0: endpoint at 0 {
-			  reg = <0>;
-			  bus-width = <8>;
+			reg = <0>;
+			bus-width = <8>;
 		};
 
 		vpif_ch1: endpoint at 1 {
-			  reg = <1>;
-			  bus-width = <8>;
-			  data-shift = <8>;
+			reg = <1>;
+			bus-width = <8>;
+			data-shift = <8>;
 		};
 	};
 };
-- 
2.9.3
