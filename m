From: romain.perier@free-electrons.com (Romain Perier)
Date: Sun, 20 Mar 2016 20:19:16 +0100
Subject: [PATCH v2] ARM: configs: Enabling the new Marvell's cryptographic
 engine driver for mvebu_v7_defconfig
Message-ID: <20160320191916.GA9910@archy.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the new driver for Marvell CESA crypto engines on all mvebu v7.

Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
---
Changes in v2:
  - Select the driver as built-in instead of module, as requested by the maintainer

 arch/arm/configs/mvebu_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index dc5797a..bedfa95 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -155,3 +155,4 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_TIMER_STATS=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_USER=y
+CONFIG_CRYPTO_DEV_MARVELL_CESA=y
-- 
2.7.4
