From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Mon, 17 Dec 2012 08:18:02 +0200
Subject: [PATCH 2/4] ARM: dt: tegra20.dtsi: Add SCU node
In-Reply-To: <1355725087-11363-1-git-send-email-hdoyu@nvidia.com>
References: <1355725087-11363-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1355725087-11363-2-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Snoop Control Unit(SCU) node for Cortex A9 MP.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/boot/dts/tegra20.dtsip |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20.dtsip b/arch/arm/boot/dts/tegra20.dtsip
index 3e046b1..d325aed 100644
--- a/arch/arm/boot/dts/tegra20.dtsip
+++ b/arch/arm/boot/dts/tegra20.dtsip
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
