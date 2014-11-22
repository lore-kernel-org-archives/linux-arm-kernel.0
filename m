From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 22 Nov 2014 17:19:50 +0100
Subject: [PATCHv0 1/2] arm: mvebu: fix wrongly named DS414 pinctrl entries
In-Reply-To: <cover.1416670812.git.arno@natisbad.org>
References: <cover.1416670812.git.arno@natisbad.org>
Message-ID: <608e4fd6e06e9c5289a84b9c38e81b2456dbcd79.1416670812.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


While renaming pinctrl entries during reviews of Synology DS414 support
series, I missed three entries, as reported by Ben. This patch fixes
those.

Reported-by: Ben Peddell <klightspeed@killerwolves.net>
Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/armada-xp-synology-ds414.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-synology-ds414.dts b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
index ba5e94d27c21..97cbf980c54d 100644
--- a/arch/arm/boot/dts/armada-xp-synology-ds414.dts
+++ b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
@@ -308,17 +308,17 @@
 		marvell,function = "gpio";
 	};
 
-	pmx_syno_id_bit1: syno-id-bit1-pin {
+	syno_id_bit1_pin: syno-id-bit1-pin {
 		marvell,pins = "mpp28";
 		marvell,function = "gpio";
 	};
 
-	pmx_syno_id_bit2: syno-id-bit2-pin {
+	syno_id_bit2_pin: syno-id-bit2-pin {
 		marvell,pins = "mpp29";
 		marvell,function = "gpio";
 	};
 
-	pmx_fan1_alarm: fan1-alarm-pin {
+	fan1_alarm_pin: fan1-alarm-pin {
 		marvell,pins = "mpp33";
 		marvell,function = "gpio";
 	};
-- 
2.1.1
