From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 25 Aug 2017 11:26:14 +0200
Subject: [PATCH 2/5] arm: dts: sun8i: a83t: Remove useless, empty nodes
In-Reply-To: <20170825092617.32533-1-maxime.ripard@free-electrons.com>
References: <20170825092617.32533-1-maxime.ripard@free-electrons.com>
Message-ID: <20170825092617.32533-2-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index f996bd343e50..8df34d8ac51d 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -54,12 +54,6 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
-	aliases {
-	};
-
-	chosen {
-	};
-
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.13.5
