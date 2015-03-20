From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Mar 2015 10:07:27 +0900
Subject: [PATCH 2/4] ARM: shmobile: Enable R-Mobile reset driver in
 multiplatform defconfig
In-Reply-To: <cover.1426813316.git.horms+renesas@verge.net.au>
References: <cover.1426813316.git.horms+renesas@verge.net.au>
Message-ID: <d4a269373ddb33bf7a07d9b9b5e8294b76768cb1.1426813316.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

This is used on R-Mobile APE6 (r8a73a4), R-Mobile A1 (r8a7740), and
SH-Mobile AG5 (sh73a0).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 21851f8..d206041 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -110,6 +110,9 @@ CONFIG_SPI_SH_HSPI=y
 CONFIG_GPIO_EM=y
 CONFIG_GPIO_RCAR=y
 CONFIG_GPIO_PCF857X=y
+CONFIG_POWER_SUPPLY=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_RMOBILE=y
 # CONFIG_HWMON is not set
 CONFIG_THERMAL=y
 CONFIG_CPU_THERMAL=y
-- 
2.1.4
