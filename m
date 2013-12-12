From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu, 12 Dec 2013 14:27:57 +0100
Subject: [PATCH 1/4] ARM: dts: imx6qdl: add aliases for can interfaces
In-Reply-To: <1386854880-21805-1-git-send-email-LW@KARO-electronics.de>
References: <1386854880-21805-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1386854880-21805-2-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 16f6974..858ecd7 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -14,6 +14,8 @@
 
 / {
 	aliases {
+		can0 = &can1;
+		can1 = &can2;
 		gpio0 = &gpio1;
 		gpio1 = &gpio2;
 		gpio2 = &gpio3;
-- 
1.7.2.5
