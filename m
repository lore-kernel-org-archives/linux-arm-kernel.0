From: s-anna@ti.com (Suman Anna)
Date: Mon, 21 Aug 2017 18:51:57 -0500
Subject: [PATCH 4/5] ARM: dts: am572x-idk: Enable relevant IPU and DSP MMU
 nodes
In-Reply-To: <20170821235158.4968-1-s-anna@ti.com>
References: <20170821235158.4968-1-s-anna@ti.com>
Message-ID: <20170821235158.4968-5-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MMU nodes for the remote processors IPU1, IPU2, DSP1 and
DSP2 have all been enabled. All these nodes are relevant and
valid for the AM572x IDK board.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/am572x-idk.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/am572x-idk.dts b/arch/arm/boot/dts/am572x-idk.dts
index a578fe97ba3b..0f3be0de82b7 100644
--- a/arch/arm/boot/dts/am572x-idk.dts
+++ b/arch/arm/boot/dts/am572x-idk.dts
@@ -127,3 +127,27 @@
 		status = "okay";
 	};
 };
+
+&mmu0_dsp1 {
+	status = "okay";
+};
+
+&mmu1_dsp1 {
+	status = "okay";
+};
+
+&mmu0_dsp2 {
+	status = "okay";
+};
+
+&mmu1_dsp2 {
+	status = "okay";
+};
+
+&mmu_ipu1 {
+	status = "okay";
+};
+
+&mmu_ipu2 {
+	status = "okay";
+};
-- 
2.13.1
