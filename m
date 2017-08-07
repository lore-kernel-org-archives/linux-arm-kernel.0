From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Mon,  7 Aug 2017 13:46:38 +1200
Subject: [RESEND PATCH 1/4] ARM: dts: enable L2 cache parity and ecc on
 db-xc3-24g4xg board
In-Reply-To: <20170807014641.4003-1-chris.packham@alliedtelesis.co.nz>
References: <20170807014641.4003-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170807014641.4003-2-chris.packham@alliedtelesis.co.nz>
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
2.13.0
