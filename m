From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Thu, 9 Jan 2014 16:31:48 +0530
Subject: [PATCH] ARM: tegra: add system-power-controller property for PMIC node
Message-ID: <1389265308-26405-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add system-power-controller property to system PMIC, ams AS3722,
node to enable power off functionality through PMIC.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/boot/dts/tegra124-venice2.dts |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index c6dcef5..1ad3f33 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -616,6 +616,8 @@
 			reg = <0x40>;
 			interrupts = <0 86 IRQ_TYPE_LEVEL_HIGH>;
 
+			ams,system-power-controller;
+
 			#interrupt-cells = <2>;
 			interrupt-controller;
 
-- 
1.7.9.5
