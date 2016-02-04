From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Feb 2016 15:29:40 +0100
Subject: [PATCH 3/8] arm64: dts: salvator-x: enable usb3.0 host channel 0
In-Reply-To: <cover.1454595726.git.horms+renesas@verge.net.au>
References: <cover.1454595726.git.horms+renesas@verge.net.au>
Message-ID: <856ea9eddbf46dc401f426da4eb3339a6baaed7b.1454595726.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 265d12ff6022..9af1e3fdc468 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -249,3 +249,7 @@
 		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
+
+&xhci0 {
+	status = "okay";
+};
-- 
2.7.0.rc3.207.g0ac5344
