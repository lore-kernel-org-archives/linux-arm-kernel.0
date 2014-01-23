From: vijay.kilari@gmail.com (vijay.kilari at gmail.com)
Date: Thu, 23 Jan 2014 21:01:37 +0530
Subject: [PATCH v8 6/6] arm64: KGDB: Add KGDB config
In-Reply-To: <1390491097-25457-1-git-send-email-vijay.kilari@gmail.com>
References: <1390491097-25457-1-git-send-email-vijay.kilari@gmail.com>
Message-ID: <1390491097-25457-5-git-send-email-vijay.kilari@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>

Add HAVE_ARCH_KGDB for arm64 Kconfig

Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
---
 arch/arm64/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d4dd22..c7a08e0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -28,6 +28,7 @@ config ARM64
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_MEMBLOCK
 	select HAVE_PERF_EVENTS
+	select HAVE_ARCH_KGDB
 	select IRQ_DOMAIN
 	select MODULES_USE_ELF_RELA
 	select NO_BOOTMEM
-- 
1.7.9.5
