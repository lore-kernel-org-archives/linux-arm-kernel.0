From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 15 Mar 2013 16:39:00 +0000
Subject: [PATCH 2/2] ARM: vexpress: Remove A9 compatible value for V2P-CA5s
 PMU node
In-Reply-To: <1363365540-23001-1-git-send-email-pawel.moll@arm.com>
References: <1363365540-23001-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1363365540-23001-3-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cortex-A5 PMU is not really compatible with Cortex-A9 one,
so remove the respective compatible value from the PMU node in
the V2P_CA5s' Device Tree.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
index 6328cbc..c544a55 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
@@ -111,7 +111,7 @@
 	};
 
 	pmu {
-		compatible = "arm,cortex-a5-pmu", "arm,cortex-a9-pmu";
+		compatible = "arm,cortex-a5-pmu";
 		interrupts = <0 68 4>,
 			     <0 69 4>;
 	};
-- 
1.7.10.4
