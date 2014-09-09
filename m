From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue,  9 Sep 2014 18:51:02 +0200
Subject: [PATCH v3 5/7] arm: dts: mt6589-aquaris5: Add boot argument
 earlyprintk
In-Reply-To: <1410281464-9587-1-git-send-email-matthias.bgg@gmail.com>
References: <1410281464-9587-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <1410281464-9587-6-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add boot argument for earlyprintk to the aquaris5 device tree file.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 arch/arm/boot/dts/mt6589-aquaris5.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/mt6589-aquaris5.dts b/arch/arm/boot/dts/mt6589-aquaris5.dts
index 443b446..74cb1ba 100644
--- a/arch/arm/boot/dts/mt6589-aquaris5.dts
+++ b/arch/arm/boot/dts/mt6589-aquaris5.dts
@@ -19,6 +19,10 @@
 / {
 	model = "bq Aquaris5";
 
+	chosen {
+		bootargs = "earlyprintk";
+	};
+
 	memory {
 		reg = <0x80000000 0x40000000>;
 	};
-- 
1.9.1
