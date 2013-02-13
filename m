From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 13 Feb 2013 10:55:26 +0000
Subject: [PATCH 8/9] highbank: enable big-endian
In-Reply-To: <1360752927-29331-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1360752927-29331-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1360752927-29331-9-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Apart from a xgmac driver issue, the highbank seems to work correctly in
big-endian mode. Allow the selection of big-endian in the system.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mach-highbank/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-highbank/Kconfig b/arch/arm/mach-highbank/Kconfig
index 551c97e..9373571 100644
--- a/arch/arm/mach-highbank/Kconfig
+++ b/arch/arm/mach-highbank/Kconfig
@@ -13,3 +13,4 @@ config ARCH_HIGHBANK
 	select HAVE_SMP
 	select SPARSE_IRQ
 	select USE_OF
+	select ARCH_SUPPORTS_BIG_ENDIAN
-- 
1.7.10.4
