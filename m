From: hch@lst.de (Christoph Hellwig)
Date: Mon,  5 Nov 2018 13:19:29 +0100
Subject: [PATCH 7/9] csky: don't select DMA_NONCOHERENT_OPS
In-Reply-To: <20181105121931.13481-1-hch@lst.de>
References: <20181105121931.13481-1-hch@lst.de>
Message-ID: <20181105121931.13481-8-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This option is gone past Linux 4.19.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/csky/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 8a30e006a845..c0cf8e948821 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -8,7 +8,6 @@ config CSKY
 	select CLKSRC_MMIO
 	select CLKSRC_OF
 	select DMA_DIRECT_OPS
-	select DMA_NONCOHERENT_OPS
 	select DMA_REMAP
 	select IRQ_DOMAIN
 	select HANDLE_DOMAIN_IRQ
-- 
2.19.1
