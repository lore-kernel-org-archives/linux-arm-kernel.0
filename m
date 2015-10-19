From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 19 Oct 2015 16:49:46 +0800
Subject: [PATCH 5/8] arm: dts: berlin: enable wdt0 on Sony NSZ-GS7
In-Reply-To: <1445244589-4838-1-git-send-email-jszhang@marvell.com>
References: <1445244589-4838-1-git-send-email-jszhang@marvell.com>
Message-ID: <1445244589-4838-6-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable wdt0 on Marvell Berlin BG2 based Sony NSZ-GS7 to make use of the
watchdog functionality.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts b/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
index 5c99fb3..f3c53b3 100644
--- a/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
+++ b/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
@@ -71,3 +71,5 @@
 };
 
 &uart0 { status = "okay"; };
+
+&wdt0 { status = "okay"; };
-- 
2.6.1
