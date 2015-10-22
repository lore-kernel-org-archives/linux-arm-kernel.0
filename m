From: mamlinav@gmail.com (Aleksei Mamlin)
Date: Thu, 22 Oct 2015 13:38:56 +0300
Subject: [PATCH] ARM: dts: sun4i: Enable audio codec on Marsboard A10.
Message-ID: <1445510336-4821-1-git-send-email-mamlinav@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable on-chip audio codec on the Marsboard A10.

Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
---
 arch/arm/boot/dts/sun4i-a10-marsboard.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-marsboard.dts b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
index 9a012db..8e50723 100644
--- a/arch/arm/boot/dts/sun4i-a10-marsboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
@@ -91,6 +91,10 @@
 	status = "okay";
 };
 
+&codec {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
-- 
2.4.10
