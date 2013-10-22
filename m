From: sre@debian.org (Sebastian Reichel)
Date: Tue, 22 Oct 2013 14:55:04 +0200
Subject: [PATCH 4/4] ARM: dts: twl4030: Add power button support
In-Reply-To: <1382446504-27837-1-git-send-email-sre@debian.org>
References: <1382446504-27837-1-git-send-email-sre@debian.org>
Message-ID: <1382446504-27837-5-git-send-email-sre@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for the power button.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/twl4030.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
index 773c94c..19e3cd0 100644
--- a/arch/arm/boot/dts/twl4030.dtsi
+++ b/arch/arm/boot/dts/twl4030.dtsi
@@ -104,4 +104,9 @@
 		keypad,num-rows = <8>;
 		keypad,num-columns = <8>;
 	};
+
+	twl_pwrbutton: pwrbutton {
+		compatible = "ti,twl4030-pwrbutton";
+		interrupts = <8>;
+	};
 };
-- 
1.8.4.rc3
