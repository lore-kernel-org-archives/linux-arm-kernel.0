From: sushaanth.s@ti.com (Sushaanth Srirangapathi)
Date: Mon, 1 Feb 2016 11:58:50 +0530
Subject: [PATCH 3/3] ARM: DTS: da850: add DT node for tps6507x-ts
In-Reply-To: <1454308130-12452-1-git-send-email-sushaanth.s@ti.com>
References: <1454308130-12452-1-git-send-email-sushaanth.s@ti.com>
Message-ID: <1454308130-12452-5-git-send-email-sushaanth.s@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add tps6507x touchscreen device tree node information to
DA850 EVM

Signed-off-by: Sushaanth Srirangapathi <sushaanth.s@ti.com>
---
 arch/arm/boot/dts/da850-evm.dts |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index ef061e9..b4f54fc 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -222,6 +222,9 @@
 			regulator-boot-on;
 		};
 	};
+	touchscreen {
+		ti,min-pressure = <0x30>;
+	};
 };
 
 &mcasp0 {
-- 
1.7.9.5
