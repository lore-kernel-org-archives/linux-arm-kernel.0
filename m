From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 21 Nov 2016 13:05:41 +0100
Subject: [PATCH 12/18] arm64: dts: m3ulcb: enable WDT
In-Reply-To: <cover.1479726397.git.horms+renesas@verge.net.au>
References: <cover.1479726397.git.horms+renesas@verge.net.au>
Message-ID: <31e12cb663b0392c9dda1c6edf0c4b22bf15232d.1479726397.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

This supports watchdog timer for M3ULCB board

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts b/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
index 5567c46f3753..593d0b4ab31a 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
@@ -90,3 +90,8 @@
 	clock-frequency = <14745600>;
 	status = "okay";
 };
+
+&wdt0 {
+	timeout-sec = <60>;
+	status = "okay";
+};
-- 
2.7.0.rc3.207.g0ac5344
