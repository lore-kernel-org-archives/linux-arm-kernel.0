From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed,  4 Jul 2018 13:43:30 +0200
Subject: [PATCH 2/5] ARM: shmobile: defconfig: Enable reset controller support
In-Reply-To: <20180704114333.27584-1-geert+renesas@glider.be>
References: <20180704114333.27584-1-geert+renesas@glider.be>
Message-ID: <20180704114333.27584-3-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

R-Car Gen2 and RZ/G1 SoCs can make use of the optional reset controller
support in the Renesas CPG/MSSR driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 393697a54fb40e08..a08d0bcdca750d28 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -193,6 +193,7 @@ CONFIG_AK8975=y
 CONFIG_PWM=y
 CONFIG_PWM_RCAR=y
 CONFIG_PWM_RENESAS_TPU=y
+CONFIG_RESET_CONTROLLER=y
 CONFIG_GENERIC_PHY=y
 CONFIG_PHY_RCAR_GEN2=y
 # CONFIG_DNOTIFY is not set
-- 
2.17.1
