From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Tue, 19 Jun 2018 13:11:53 +0900
Subject: [PATCH 2/2] arm64: dts: uniphier: add headphone detect gpio for LD11
 global board
In-Reply-To: <20180619041153.6668-1-suzuki.katsuhiro@socionext.com>
References: <20180619041153.6668-1-suzuki.katsuhiro@socionext.com>
Message-ID: <20180619041153.6668-2-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds GPIO for headphone detection on LD11 global board.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
index 798882cccbd6..e5bda40b3ec6 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
@@ -60,6 +60,7 @@
 			&i2s_port4
 			&spdif_port0
 			&comp_spdif_port0>;
+		hp-det-gpio = <&gpio UNIPHIER_GPIO_PORT(15, 0) GPIO_ACTIVE_LOW>;
 	};
 
 	spdif-out {
-- 
2.17.1
