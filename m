From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Fri, 28 Aug 2015 17:59:44 +0200
Subject: [PATCH 09/11] arm: tegra: colibri_t30: fix vendor string of m41t0m6
 rtc on eval board
In-Reply-To: <1440777586-19545-1-git-send-email-marcel.ziswiler@toradex.com>
References: <1440777586-19545-1-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <1440777586-19545-10-git-send-email-marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix compatible vendor string of M41T0M6 real time clock as found on the
Colibri Evaluation board.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index 4d3ddc5..46a7c2d 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -55,7 +55,7 @@
 
 		/* M41T0M6 real time clock on carrier board */
 		rtc at 68 {
-			compatible = "stm,m41t00";
+			compatible = "st,m41t00";
 			reg = <0x68>;
 		};
 	};
-- 
2.4.3
