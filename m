From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Tue,  9 Jan 2018 11:31:56 +1300
Subject: [PATCH 1/3] ARM: dts: enable L2 cache parity and ecc on db-xc3-24g4xg
 board
In-Reply-To: <20180108223158.21930-1-chris.packham@alliedtelesis.co.nz>
References: <20180108223158.21930-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20180108223158.21930-2-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts b/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
index 06fce35d7491..00ca489fc788 100644
--- a/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
+++ b/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
@@ -70,6 +70,11 @@
 	};
 };
 
+&L2 {
+	arm,parity-enable;
+	marvell,ecc-enable;
+};
+
 &devbus_bootcs {
 	status = "okay";
 
-- 
2.15.1
