From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 29 Apr 2014 11:15:33 +0900
Subject: [PATCH 3/3] ARM: shmobile: henninger: enable SATA0
In-Reply-To: <cover.1398737464.git.horms+renesas@verge.net.au>
References: <cover.1398737464.git.horms+renesas@verge.net.au>
Message-ID: <5a62ec57004f1a434bfd3feed43e447b5780baf6.1398737464.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Enable SATA0 device for the Henninger board.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-henninger.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-henninger.dts b/arch/arm/boot/dts/r8a7791-henninger.dts
index f82f306..6e67cea 100644
--- a/arch/arm/boot/dts/r8a7791-henninger.dts
+++ b/arch/arm/boot/dts/r8a7791-henninger.dts
@@ -74,3 +74,7 @@
 		micrel,led-mode = <1>;
 	};
 };
+
+&sata0 {
+       status = "okay";
+};
-- 
1.8.5.2
