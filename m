From: dja@axtens.net (Daniel Axtens)
Date: Wed, 19 Jul 2017 11:28:37 +1000
Subject: [PATCH 3/3] extend to arm
In-Reply-To: <20170719012839.20124-1-dja@axtens.net>
References: <20170719012839.20124-1-dja@axtens.net>
Message-ID: <20170719012839.20124-5-dja@axtens.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index cae4e677a181..e88081b515d2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -20,6 +20,7 @@ config ARM64
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select ARCH_WANT_FRAME_POINTERS
+	select ARCH_WANT_VGA_ARB_FALLBACK
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARM_AMBA
 	select ARM_ARCH_TIMER
-- 
2.11.0
