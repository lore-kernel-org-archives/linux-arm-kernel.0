From: carlo@caione.org (Carlo Caione)
Date: Thu, 11 Sep 2014 22:11:40 +0200
Subject: [PATCH v2 9/9] ARM: meson: update multi_v7_defconfig
In-Reply-To: <1410466300-19168-1-git-send-email-carlo@caione.org>
References: <1410466300-19168-1-git-send-email-carlo@caione.org>
Message-ID: <1410466300-19168-10-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the multi_v7_defconfig with the CONFIG_* needed by
the just added Meson anch. It also adds a new defconfig specifically for
the Meson SoCs.

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 5348364..4a853f2 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -26,6 +26,7 @@ CONFIG_MACH_BERLIN_BG2Q=y
 CONFIG_ARCH_HIGHBANK=y
 CONFIG_ARCH_HI3xxx=y
 CONFIG_ARCH_KEYSTONE=y
+CONFIG_ARCH_MESON=y
 CONFIG_ARCH_MXC=y
 CONFIG_MACH_IMX51_DT=y
 CONFIG_SOC_IMX53=y
@@ -165,6 +166,8 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
+CONFIG_SERIAL_MESON=y
+CONFIG_SERIAL_MESON_CONSOLE=y
 CONFIG_SERIAL_SAMSUNG=y
 CONFIG_SERIAL_SAMSUNG_CONSOLE=y
 CONFIG_SERIAL_SIRFSOC=y
-- 
1.9.1
