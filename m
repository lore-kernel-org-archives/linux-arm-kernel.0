From: roy.pledge@nxp.com (Roy Pledge)
Date: Wed, 29 Mar 2017 17:13:57 -0400
Subject: [RFC PATCH 5/5] powerpc: Add HAVE_GENERIC_DMA_COHERENT options to
 Kconfig
In-Reply-To: <1490822037-6752-1-git-send-email-roy.pledge@nxp.com>
References: <1490822037-6752-1-git-send-email-roy.pledge@nxp.com>
Message-ID: <1490822037-6752-6-git-send-email-roy.pledge@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable HAVE_GENERIC_DMA_COHERENT to enable use of shared-dma-pool
reserved memory mappings

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 186e060..0e80e8b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -136,6 +136,7 @@ config PPC
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GCC_PLUGINS
+	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_GENERIC_GUP
 	select HAVE_HW_BREAKPOINT		if PERF_EVENTS && (PPC_BOOK3S || PPC_8xx)
 	select HAVE_IDE
-- 
2.9.3
