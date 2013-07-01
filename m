From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon,  1 Jul 2013 12:04:06 +0100
Subject: [PATCH 08/10] highbank: enable big-endian
In-Reply-To: <1372676648-9254-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1372676648-9254-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1372676648-9254-9-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Apart from a xgmac driver issue, the highbank seems to work correctly in
big-endian mode. Allow the selection of big-endian in the system.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mach-highbank/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-highbank/Kconfig b/arch/arm/mach-highbank/Kconfig
index cd9fcb1..4f57554 100644
--- a/arch/arm/mach-highbank/Kconfig
+++ b/arch/arm/mach-highbank/Kconfig
@@ -18,3 +18,4 @@ config ARCH_HIGHBANK
 	select PL320_MBOX
 	select SPARSE_IRQ
 	select USE_OF
+	select ARCH_SUPPORTS_BIG_ENDIAN
-- 
1.7.10.4
