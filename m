From: carlo@caione.org (Carlo Caione)
Date: Mon, 15 Sep 2014 16:45:02 +0200
Subject: [PATCH 5/6] ARM: meson: update multi_v7_defconfig
In-Reply-To: <1410792303-23275-1-git-send-email-carlo@caione.org>
References: <1410792303-23275-1-git-send-email-carlo@caione.org>
Message-ID: <1410792303-23275-6-git-send-email-carlo@caione.org>
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
index 5fb95fb..5b44796 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -29,6 +29,7 @@ CONFIG_ARCH_HISI=y
 CONFIG_ARCH_HI3xxx=y
 CONFIG_ARCH_HIX5HD2=y
 CONFIG_ARCH_KEYSTONE=y
+CONFIG_ARCH_MESON=y
 CONFIG_ARCH_MXC=y
 CONFIG_SOC_IMX51=y
 CONFIG_SOC_IMX53=y
@@ -173,6 +174,8 @@ CONFIG_SERIAL_8250_CONSOLE=y
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
