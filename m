From: jakllsch@kollasch.net (Jonathan A. Kollasch)
Date: Tue,  3 Jul 2018 08:26:36 -0500
Subject: [PATCH] dts: fix status gpioleds on nanopi-neo-plus2
Message-ID: <20180703132636.21587-1-jakllsch@kollasch.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jonathan A. Kollasch <jakllsch@kollasch.net>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
index 506e25ba028a..b8eb43a0d007 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
@@ -71,8 +71,8 @@
 		};
 
 		status {
-			label = "nanopi:red:status";
-			gpios = <&pio 0 20 GPIO_ACTIVE_HIGH>;
+			label = "nanopi:blue:status";
+			gpios = <&pio 0 10 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
-- 
2.11.0
