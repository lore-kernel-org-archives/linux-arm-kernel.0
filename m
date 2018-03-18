From: stefan@agner.ch (Stefan Agner)
Date: Sun, 18 Mar 2018 21:34:42 +0100
Subject: [PATCH 7/7] ARM: multi_v7_defconfig: add NXP graphics drivers
In-Reply-To: <20180318203442.19759-1-stefan@agner.ch>
References: <20180318203442.19759-1-stefan@agner.ch>
Message-ID: <20180318203442.19759-7-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable drivers to support NXP graphics IPs such as:
- Etnaviv (e.g. i.MX6)
- DCU (e.g. Vybrid LS1021A)
- mxsfb (e.g. i.MX6UL/ULL/7)

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 61968bd6cccc..403d0e7156aa 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -623,6 +623,7 @@ CONFIG_DRM_ATMEL_HLCDC=m
 CONFIG_DRM_RCAR_DU=m
 CONFIG_DRM_RCAR_LVDS=y
 CONFIG_DRM_SUN4I=m
+CONFIG_DRM_FSL_DCU=m
 CONFIG_DRM_TEGRA=y
 CONFIG_DRM_PANEL_SAMSUNG_LD9040=m
 CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
@@ -630,6 +631,8 @@ CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_SII9234=m
 CONFIG_DRM_STI=m
 CONFIG_DRM_VC4=y
+CONFIG_DRM_ETNAVIV=m
+CONFIG_DRM_MXSFB=m
 CONFIG_FB_ARMCLCD=y
 CONFIG_FB_EFI=y
 CONFIG_FB_WM8505=y
-- 
2.16.2
