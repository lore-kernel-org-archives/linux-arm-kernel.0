From: s-anna@ti.com (Suman Anna)
Date: Fri, 11 Jul 2014 16:44:37 -0500
Subject: [PATCHv2 04/10] ARM: dts: AM4372: Correct mailbox node data
In-Reply-To: <1405115083-52977-1-git-send-email-s-anna@ti.com>
References: <1405115083-52977-1-git-send-email-s-anna@ti.com>
Message-ID: <1405115083-52977-5-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mailbox DT node for AM4372 is enabled and is corrected to
remove some properties that have crept in by mistake.

Fixes: 9e3269b (ARM: dts: AM4372: Add L2, EDMA, mailbox, MMC and SHAM nodes)
Cc: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 49fa596..c9aee0e 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -168,9 +168,6 @@
 			ti,hwmods = "mailbox";
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <8>;
-			ti,mbox-names = "wkup_m3";
-			ti,mbox-data = <0 0 0 0>;
-			status = "disabled";
 		};
 
 		timer1: timer at 44e31000 {
-- 
2.0.0
