From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 11 Apr 2018 16:53:57 +0800
Subject: [PATCH v2 04/12] arm: dts: mt7623: fix available memory size on
 bananapi-r2
In-Reply-To: <cover.1523434757.git.sean.wang@mediatek.com>
References: <cover.1523434757.git.sean.wang@mediatek.com>
Message-ID: <705d03d06a7668d66689777bb90806953e0744b3.1523434758.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

There is 2GB DDR3 available on bananapi-r2 board as [1] specified.

[1] http://www.banana-pi.org/r2.html

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>
---
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index 5938e4c..d2a354e 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -110,7 +110,7 @@
 
 	memory at 80000000 {
 		device_type = "memory";
-		reg = <0 0x80000000 0 0x40000000>;
+		reg = <0 0x80000000 0 0x80000000>;
 	};
 };
 
-- 
2.7.4
