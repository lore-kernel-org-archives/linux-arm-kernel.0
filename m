From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 16 Feb 2017 21:50:35 +1300
Subject: [PATCH v3 1/6] ARM: dts: Fix typo in armada-xp-98dx4251
In-Reply-To: <20170216085041.28337-1-chris.packham@alliedtelesis.co.nz>
References: <20170216085041.28337-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170216085041.28337-2-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The compatible should be 98dx4251 not 98dx4521.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v2:
    - new
    Changes in v3:
    - none

 arch/arm/boot/dts/armada-xp-98dx4251.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-xp-98dx4251.dtsi b/arch/arm/boot/dts/armada-xp-98dx4251.dtsi
index 4b0533a4ccb7..b9d9b269efb4 100644
--- a/arch/arm/boot/dts/armada-xp-98dx4251.dtsi
+++ b/arch/arm/boot/dts/armada-xp-98dx4251.dtsi
@@ -49,7 +49,7 @@
 
 / {
 	model = "Marvell 98DX4251 SoC";
-	compatible = "marvell,armadaxp-98dx4521", "marvell,armadaxp-98dx3236", "marvell,armadaxp", "marvell,armada-370-xp";
+	compatible = "marvell,armadaxp-98dx4251", "marvell,armadaxp-98dx3236", "marvell,armadaxp", "marvell,armada-370-xp";
 
 	cpus {
 		cpu at 1 {
-- 
2.11.0.24.ge6920cf
