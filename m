From: romain.perier@gmail.com (Romain Perier)
Date: Mon, 27 Oct 2014 16:26:53 +0000
Subject: [PATCH v2 08/10] ARM: dts: tegra: Use standard power-off property in
 tps65911 for tegra30 beaver
In-Reply-To: <1414427215-14380-1-git-send-email-romain.perier@gmail.com>
References: <1414427215-14380-1-git-send-email-romain.perier@gmail.com>
Message-ID: <1414427215-14380-8-git-send-email-romain.perier@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/tegra30-beaver.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index cee8f22..4abaf7f 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -188,7 +188,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 
-			ti,system-power-controller;
+			system-power-controller;
 
 			#gpio-cells = <2>;
 			gpio-controller;
-- 
1.9.1
