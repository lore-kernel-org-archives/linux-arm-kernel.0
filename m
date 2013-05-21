From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 21 May 2013 14:14:26 +0200
Subject: [PATCH v4 05/21] ARM: shmobile: r8a7778: Add pin control device to
 device tree
In-Reply-To: <1369138482-5871-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1369138482-5871-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1369138482-5871-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a pfc node to the r8a7778 device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7778.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 4743735..c8dbf14 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -32,4 +32,9 @@
 		reg = <0xfe438000 0x1000>,
 		      <0xfe430000 0x100>;
 	};
+
+	pfc: pfc at fffc0000 {
+		compatible = "renesas,pfc-r8a7778";
+		reg = <0xfffc000 0x118>;
+	};
 };
-- 
1.8.1.5
