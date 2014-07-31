From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 31 Jul 2014 18:42:21 +0200
Subject: [PATCH 5/7] arm: dts: mt6589-aquaris5: Add boot argument earlyprintk
In-Reply-To: <1406824943-24052-1-git-send-email-matthias.bgg@gmail.com>
References: <1406824943-24052-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <1406824943-24052-6-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add boot argument for earlyprintk to the aquaris5 device tree file.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 arch/arm/boot/dts/mt6589-aquaris5.dts |    4 ++++
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
1.7.9.5
