From: bonbons@linux-vserver.org (Bruno =?UTF-8?B?UHLDqW1vbnQ=?=)
Date: Mon, 20 Oct 2014 22:33:31 +0200
Subject: [RFC Patch 4/4] mfd: AXP20x: Add backup battery DTS entry for
 Cubietruck
In-Reply-To: <20141020215954.7f1d5502@neptune.home>
References: <20141020215954.7f1d5502@neptune.home>
Message-ID: <20141020223331.4e2a5b78@neptune.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts       |    4 +
 1 files changed, 2 insertions(+), 0 deletion(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index a6c1a3c..efb65fb 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -125,6 +125,8 @@
 
 				interrupt-controller;
 				#interrupt-cells = <1>;
+
+				backup = <3000000 200>;
 			};
 		};
 
-- 
2.0.4
