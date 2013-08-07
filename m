From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:28:40 +0900
Subject: [GIT PULL 19/19] ARM: shmobile: r8a7740: Add TPU node to the device
 tree
In-Reply-To: <cover.1375838900.git.horms+renesas@verge.net.au>
References: <cover.1375838900.git.horms+renesas@verge.net.au>
Message-ID: <8b3e32c1fe5dce55e28e76b20361841dc863ec17.1375838900.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 4b0728f..27f014f 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -144,4 +144,11 @@
 			      0 72 0x4
 			      0 73 0x4>;
 	};
+
+	tpu: pwm at e6600000 {
+		compatible = "renesas,tpu-r8a7740", "renesas,tpu";
+		reg = <0xe6600000 0x100>;
+		status = "disabled";
+		#pwm-cells = <3>;
+	};
 };
-- 
1.8.3.2
