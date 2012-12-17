From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Mon, 17 Dec 2012 08:18:03 +0200
Subject: [PATCH 3/4] ARM: dt: tegra30.dtsi: Add SCU node
In-Reply-To: <1355725087-11363-1-git-send-email-hdoyu@nvidia.com>
References: <1355725087-11363-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1355725087-11363-3-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Snoop Control Unit(SCU) node for Cortex A9 MP.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/boot/dts/tegra30.dtsip |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30.dtsip b/arch/arm/boot/dts/tegra30.dtsip
index 8feba6d..84a41c2 100644
--- a/arch/arm/boot/dts/tegra30.dtsip
+++ b/arch/arm/boot/dts/tegra30.dtsip
@@ -91,6 +91,11 @@
 		};
 	};
 
+	scu {
+		compatible = "arm,cortex-a9-scu";
+		reg = <0x50040000 0x58>;
+	};
+
 	timer at 50004600 {
 		compatible = "arm,cortex-a9-twd-timer";
 		reg = <0x50040600 0x20>;
-- 
1.7.9.5
