From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu,  8 Jun 2017 16:11:24 +1200
Subject: [RFC PATCH 4/4] ARM: dts: enable l2c parity and ecc protection on
 98dx3236
In-Reply-To: <20170608041124.4624-1-chris.packham@alliedtelesis.co.nz>
References: <20170608041124.4624-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170608041124.4624-5-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
index 84cc232a29e9..32d05ec88ffd 100644
--- a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
+++ b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
@@ -138,6 +138,8 @@
 				cache-level = <2>;
 				cache-unified;
 				wt-override;
+				arm,parity-enable;
+				arm,ecc-enable;
 			};
 
 			gpio0: gpio at 18100 {
-- 
2.13.0
