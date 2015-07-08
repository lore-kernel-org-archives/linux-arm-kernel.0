From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 8 Jul 2015 20:57:37 +0530
Subject: [PATCH 4/4] ARM: omap2plus_defconfig: enable support for M25P80 SPI
 NOR
In-Reply-To: <cover.1436368740.git.nsekhar@ti.com>
References: <cover.1436368740.git.nsekhar@ti.com>
Message-ID: <0477453cab345f3926262eb7c864a1f387872c6e.1436368740.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

M25P80 driver provides support for most common SPI NOR devices.
These devices are commonly found on TI EVMs for AM437x and DRA7x
SoCs.

Enable support for this driver in defconfig for omap2plus devices.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 4cb1c11d83ad..f7dec31bc264 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -136,6 +136,8 @@ CONFIG_MTD_ONENAND=y
 CONFIG_MTD_ONENAND_VERIFY_WRITE=y
 CONFIG_MTD_ONENAND_OMAP2=y
 CONFIG_MTD_UBI=y
+CONFIG_MTD_SPI_NOR=m
+CONFIG_MTD_M25P80=m
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=16384
-- 
2.4.4.408.g16da57c
