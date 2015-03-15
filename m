From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 15 Mar 2015 23:00:30 +0100
Subject: [PATCH v4 1/5] ARM: dts: Clean up exynos5410-smdk5410 indentation
In-Reply-To: <1426456834-6308-1-git-send-email-afaerber@suse.de>
References: <1426456834-6308-1-git-send-email-afaerber@suse.de>
Message-ID: <1426456834-6308-2-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UART status properties are indented one level too deep, and we want
to derive a device tree for the ODROID-XU. Fix this before it propagates.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v1 -> v2 -> v3: Unchanged
 
 arch/arm/boot/dts/exynos5410-smdk5410.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5410-smdk5410.dts b/arch/arm/boot/dts/exynos5410-smdk5410.dts
index be3e02530b42..cebeaab3abec 100644
--- a/arch/arm/boot/dts/exynos5410-smdk5410.dts
+++ b/arch/arm/boot/dts/exynos5410-smdk5410.dts
@@ -62,13 +62,13 @@
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
2.3.1
