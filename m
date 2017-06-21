From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Wed, 21 Jun 2017 18:01:53 +0800
Subject: [RFC PATCH v3 6/6] ARM: dts: cros-ec-keyboard: enable as wakeup source
In-Reply-To: <1498039313-24220-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1498039313-24220-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <1498039313-24220-7-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable cros-ec-keyboard as a wakeup source.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v3: None

 arch/arm/boot/dts/cros-ec-keyboard.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/cros-ec-keyboard.dtsi b/arch/arm/boot/dts/cros-ec-keyboard.dtsi
index c0451051..3168a5e 100644
--- a/arch/arm/boot/dts/cros-ec-keyboard.dtsi
+++ b/arch/arm/boot/dts/cros-ec-keyboard.dtsi
@@ -16,6 +16,7 @@
 		keypad,num-rows = <8>;
 		keypad,num-columns = <13>;
 		google,needs-ghost-filter;
+		wakeup-source;
 
 		linux,keymap = <
 			MATRIX_KEY(0x00, 0x01, KEY_LEFTMETA)
-- 
2.1.4
