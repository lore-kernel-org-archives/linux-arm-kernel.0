From: romain.perier@gmail.com (Romain Perier)
Date: Wed, 22 Oct 2014 15:26:27 +0000
Subject: [PATCH v1 5/5] ARM: dts: tegra: Use poweroff-source DT property in
 tps65911 for tegra30 colibri
In-Reply-To: <1413991587-11110-1-git-send-email-romain.perier@gmail.com>
References: <1413991587-11110-1-git-send-email-romain.perier@gmail.com>
Message-ID: <1413991587-11110-5-git-send-email-romain.perier@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/tegra30-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index c4ed1be..e35c4d4 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -190,7 +190,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 
-			ti,system-power-controller;
+			poweroff-source;
 
 			#gpio-cells = <2>;
 			gpio-controller;
-- 
1.9.1
