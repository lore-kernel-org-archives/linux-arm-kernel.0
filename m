From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue,  4 Feb 2014 16:23:57 +0100
Subject: [PATCH v3 03/11] ARM: shmobile: genmai defconfig: Enable RSPI
In-Reply-To: <1391527445-14881-1-git-send-email-geert@linux-m68k.org>
References: <1391527445-14881-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1391527445-14881-4-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
v3:
  - Rebased on top of renesas-devel-v3.14-rc1-20140204
v2:
  - No changes

 arch/arm/configs/genmai_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/genmai_defconfig b/arch/arm/configs/genmai_defconfig
index c56a7ff1dcd7..5ee6ac0931f7 100644
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
1.7.9.5
