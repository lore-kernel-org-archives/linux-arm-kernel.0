From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Mon, 25 Jun 2018 12:45:05 +0900
Subject: [PATCH v2 2/2] arm64: dts: uniphier: add headphone detect gpio for
 LD11 global board
In-Reply-To: <20180625034505.1404-1-suzuki.katsuhiro@socionext.com>
References: <20180625034505.1404-1-suzuki.katsuhiro@socionext.com>
Message-ID: <20180625034505.1404-2-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds GPIO for headphone detection on LD11 global board.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
index 798882cccbd6..eb6a5b914fdb 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
@@ -60,6 +60,7 @@
 			&i2s_port4
 			&spdif_port0
 			&comp_spdif_port0>;
+		hp-det-gpio = <&gpio UNIPHIER_GPIO_IRQ(0) GPIO_ACTIVE_LOW>;
 	};
 
 	spdif-out {
-- 
2.18.0
