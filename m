From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu, 10 Aug 2017 10:51:28 +0200
Subject: [PATCH 2/3] ARM: sun8i: sunxi-h3-h5: add phy-is-integrated property
 to internal PHY
In-Reply-To: <20170810085129.20463-1-clabbe.montjoie@gmail.com>
References: <20170810085129.20463-1-clabbe.montjoie@gmail.com>
Message-ID: <20170810085129.20463-3-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the new phy-is-integrated property to the internal PHY
node.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 4b599b5d26f6..54fc24e4c569 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -425,6 +425,7 @@
 					reg = <1>;
 					clocks = <&ccu CLK_BUS_EPHY>;
 					resets = <&ccu RST_BUS_EPHY>;
+					phy-is-integrated;
 				};
 			};
 		};
-- 
2.13.0
