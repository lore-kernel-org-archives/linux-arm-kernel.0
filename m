From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Feb 2014 17:04:36 +0900
Subject: [PATCH 4/4] ARM: shmobile: genmai defconfig: Enable RSPI
In-Reply-To: <cover.1392276997.git.horms+renesas@verge.net.au>
References: <cover.1392276997.git.horms+renesas@verge.net.au>
Message-ID: <8f33d31ee270f2a6bcc661815a520f76565674c3.1392276997.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/genmai_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/genmai_defconfig b/arch/arm/configs/genmai_defconfig
index c56a7ff..5ee6ac0 100644
--- a/arch/arm/configs/genmai_defconfig
+++ b/arch/arm/configs/genmai_defconfig
@@ -81,6 +81,8 @@ CONFIG_SERIAL_SH_SCI_NR_UARTS=10
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C_SH_MOBILE=y
+CONFIG_SPI=y
+CONFIG_SPI_RSPI=y
 # CONFIG_HWMON is not set
 CONFIG_THERMAL=y
 CONFIG_RCAR_THERMAL=y
-- 
1.8.5.2
