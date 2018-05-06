From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun,  6 May 2018 15:43:51 +0200
Subject: [PATCH 6/7] ARM: dts: Add second ATA to NAS4220B
In-Reply-To: <20180506134352.2637-1-linus.walleij@linaro.org>
References: <20180506134352.2637-1-linus.walleij@linaro.org>
Message-ID: <20180506134352.2637-7-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NAS4220B has the second ATA interface up and running.
Activate it in the device tree.

Signed-off-by: Roman Yeryomin <roman@advem.lv>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/gemini-nas4220b.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/gemini-nas4220b.dts b/arch/arm/boot/dts/gemini-nas4220b.dts
index 465c26b53212..9f78803b2456 100644
--- a/arch/arm/boot/dts/gemini-nas4220b.dts
+++ b/arch/arm/boot/dts/gemini-nas4220b.dts
@@ -202,5 +202,9 @@
 		ata at 63000000 {
 			status = "okay";
 		};
+
+		ata at 63400000 {
+			status = "okay";
+		};
 	};
 };
-- 
2.17.0
