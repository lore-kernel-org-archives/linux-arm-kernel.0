From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  5 Apr 2012 11:25:32 +0100
Subject: [PATCH 5/7] ARM: ux500: Rename gpio_keys in the Device Tree file
In-Reply-To: <1333621534-29627-1-git-send-email-lee.jones@linaro.org>
References: <1333621534-29627-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1333621534-29627-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure each button is individually identifiable by using
their correct unique given device names.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/snowball.dts |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index 738959d..0cec47b 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -36,28 +36,28 @@
 			debounce_interval = <50>;
 			wakeup = <1>;
 			linux,code = <3>;
-			label = "userpb";
+			label = "extkb1";
 			gpios = <&gpio4 23 0>;
 		};
 		button at 3 {
 			debounce_interval = <50>;
 			wakeup = <1>;
 			linux,code = <4>;
-			label = "userpb";
+			label = "extkb2";
 			gpios = <&gpio4 24 0>;
 		};
 		button at 4 {
 			debounce_interval = <50>;
 			wakeup = <1>;
 			linux,code = <5>;
-			label = "userpb";
+			label = "extkb3";
 			gpios = <&gpio5 1 0>;
 		};
 		button at 5 {
 			debounce_interval = <50>;
 			wakeup = <1>;
 			linux,code = <6>;
-			label = "userpb";
+			label = "extkb4";
 			gpios = <&gpio5 2 0>;
 		};
 	};
-- 
1.7.9.1
