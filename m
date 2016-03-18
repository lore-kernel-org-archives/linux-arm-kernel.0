From: romain.perier@free-electrons.com (Romain Perier)
Date: Fri, 18 Mar 2016 09:12:09 +0100
Subject: [PATCH] ARM: configs: Enabling the new Marvell's cryptographic
 engine driver for mvebu_v7_defconfig
Message-ID: <20160318081209.GA7394@archy.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the new driver for Marvell CESA crypto engines on all mvebu v7.

Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
---
 arch/arm/configs/mvebu_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index dc5797a..26a8919 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -155,3 +155,4 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_TIMER_STATS=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_USER=y
+CONFIG_CRYPTO_DEV_MARVELL_CESA=m
-- 
2.7.3
