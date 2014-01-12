From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 12 Jan 2014 11:48:43 +0100
Subject: [PATCH V3 5/5] ARM: shmobile: genmai: Enable RSPI in defconfig
In-Reply-To: <1389523723-2288-1-git-send-email-geert@linux-m68k.org>
References: <1389523723-2288-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1389523723-2288-6-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
V3:
  - New

 arch/arm/configs/genmai_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/genmai_defconfig b/arch/arm/configs/genmai_defconfig
index ede35f400df2..401285305251 100644
--- a/arch/arm/configs/genmai_defconfig
+++ b/arch/arm/configs/genmai_defconfig
@@ -79,6 +79,8 @@ CONFIG_SERIAL_SH_SCI_NR_UARTS=10
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C_SH_MOBILE=y
+CONFIG_SPI=y
+CONFIG_SPI_RSPI=y
 # CONFIG_HWMON is not set
 CONFIG_THERMAL=y
 CONFIG_RCAR_THERMAL=y
-- 
1.7.9.5
