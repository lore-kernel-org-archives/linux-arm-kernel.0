From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Fri, 28 Aug 2015 17:59:45 +0200
Subject: [PATCH 10/11] arm: tegra: colibri_t30: add comment concerning sd/mmc
 for eval board
In-Reply-To: <1440777586-19545-1-git-send-email-marcel.ziswiler@toradex.com>
References: <1440777586-19545-1-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <1440777586-19545-11-git-send-email-marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of adding an otherwise unused sdmmc label just add a comment.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index 46a7c2d..a6c98b1 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -84,6 +84,7 @@
 		};
 	};
 
+	/* SD/MMC */
 	sdhci at 78000200 {
 		status = "okay";
 		bus-width = <4>;
-- 
2.4.3
