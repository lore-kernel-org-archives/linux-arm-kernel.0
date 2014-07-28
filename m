From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 28 Jul 2014 14:18:08 +0200
Subject: [PATCH 1/5] ARM: dts: exynos5410: Clean up SMDK5410 indentation
In-Reply-To: <1406549892-5558-1-git-send-email-afaerber@suse.de>
References: <1406549892-5558-1-git-send-email-afaerber@suse.de>
Message-ID: <1406549892-5558-2-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UART status properties are indented one level too deep, and we want
to derive a device tree for the ODROID-XU. Fix this before it propagates.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/exynos5410-smdk5410.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5410-smdk5410.dts b/arch/arm/boot/dts/exynos5410-smdk5410.dts
index 7275bbd6fc4b..4c495de1bf68 100644
--- a/arch/arm/boot/dts/exynos5410-smdk5410.dts
+++ b/arch/arm/boot/dts/exynos5410-smdk5410.dts
@@ -70,13 +70,13 @@
 };
 
 &uart0 {
-		status = "okay";
+	status = "okay";
 };
 
 &uart1 {
-		status = "okay";
+	status = "okay";
 };
 
 &uart2 {
-		status = "okay";
+	status = "okay";
 };
-- 
1.9.3
