From: silvio.fricke@gmail.com (Silvio Fricke)
Date: Sat, 13 Dec 2014 02:46:47 +0100
Subject: [PATCH 2/3] ARM: tegra: dts: remove unused irq-trigger entry
In-Reply-To: <cover.1418434448.git.silvio.fricke@gmail.com>
References: <cover.1418434448.git.silvio.fricke@gmail.com>
Message-ID: <bc18448982ba1fb8b976443193937a8bc6cc4c23.1418434448.git.silvio.fricke@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Silvio Fricke <silvio.fricke@gmail.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Jason Cooper <jason@lakedaemon.net>
CC: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/boot/dts/tegra30-apalis.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index a5446cb..c2a7528 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -540,7 +540,6 @@
 			interrupt-controller;
 			id = <0>;
 			blocks = <0x5>;
-			irq-trigger = <0x1>;
 
 			stmpe_touchscreen {
 				compatible = "st,stmpe-ts";
-- 
2.1.3
