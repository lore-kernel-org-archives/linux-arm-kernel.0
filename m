From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Tue, 4 Jul 2017 18:15:07 +0800
Subject: [PATCH 1/2] arm64: dts: add Spreadtrum's fm support
In-Reply-To: <20170704101508.30946-1-chunyan.zhang@spreadtrum.com>
References: <20170704101508.30946-1-chunyan.zhang@spreadtrum.com>
Message-ID: <20170704101508.30946-2-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added FM support for Spreadtrum's SP9860 board.

Signed-off-by: Songhe Wei <songhe.wei@spreadtrum.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
index 0362ecd..6fe052d 100644
--- a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
+++ b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
@@ -39,6 +39,10 @@
 		#size-cells = <2>;
 		ranges;
 	};
+
+	sprd-fm {
+		compatible  = "sprd,marlin2-fm";
+	};
 };
 
 &uart0 {
-- 
2.7.4
