From: marek@goldelico.com (Marek Belisko)
Date: Fri, 14 Feb 2014 14:17:41 +0100
Subject: [PATCH 2/2] ARM: dts: twl4030: Add twl4030-madc node.
In-Reply-To: <1392383861-14169-1-git-send-email-marek@goldelico.com>
References: <1392383861-14169-1-git-send-email-marek@goldelico.com>
Message-ID: <1392383861-14169-2-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/twl4030.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
index 4217096..e6dec53 100644
--- a/arch/arm/boot/dts/twl4030.dtsi
+++ b/arch/arm/boot/dts/twl4030.dtsi
@@ -145,4 +145,9 @@
 		compatible = "ti,twl4030-pwrbutton";
 		interrupts = <8>;
 	};
+
+	twl_madc: madc {
+		compatible = "ti,twl4030-madc";
+		interrupts = <1>;
+	};
 };
-- 
1.8.3.2
