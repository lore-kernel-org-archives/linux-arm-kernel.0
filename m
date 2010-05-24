From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 24 May 2010 14:35:44 +0800
Subject: [PATCH 1/6] [ARM] pxa: select SPARSE_IRQ by default
In-Reply-To: <1274682949-25915-1-git-send-email-eric.y.miao@gmail.com>
References: <1274682949-25915-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1274682949-25915-2-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 02df4fd..dece838 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -579,6 +579,7 @@ config ARCH_PXA
 	select GENERIC_CLOCKEVENTS
 	select TICK_ONESHOT
 	select PLAT_PXA
+	select SPARSE_IRQ
 	help
 	  Support for Intel/Marvell's PXA2xx/PXA3xx processor line.
 
-- 
1.7.0.4
