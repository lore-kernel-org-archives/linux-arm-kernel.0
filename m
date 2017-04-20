From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Fri, 21 Apr 2017 09:58:13 +1200
Subject: [PATCH 1/2] ARM: dts: mvebu: add missing interrupt to 98dx4251 switch
In-Reply-To: <20170420215814.6817-1-chris.packham@alliedtelesis.co.nz>
References: <20170420215814.6817-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170420215814.6817-2-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 98dx4251 has 4 interrupts for the packet processor whereas the
98dx3236 and 98dx3336 only have 3.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/boot/dts/armada-xp-98dx4251.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/armada-xp-98dx4251.dtsi b/arch/arm/boot/dts/armada-xp-98dx4251.dtsi
index 51de91b31a9d..bc9f824020eb 100644
--- a/arch/arm/boot/dts/armada-xp-98dx4251.dtsi
+++ b/arch/arm/boot/dts/armada-xp-98dx4251.dtsi
@@ -87,4 +87,5 @@
 
 &pp0 {
 	compatible = "marvell,prestera-98dx4251";
+	interrupts = <33>, <34>, <35>, <36>;
 };
-- 
2.11.0.24.ge6920cf
