From: vijay.kilari@gmail.com (vijay.kilari at gmail.com)
Date: Wed, 19 Feb 2014 10:05:41 +0530
Subject: [PATCH v10 6/6] arm64: KGDB: Add KGDB config
In-Reply-To: <1392784541-18034-1-git-send-email-vijay.kilari@gmail.com>
References: <1392784541-18034-1-git-send-email-vijay.kilari@gmail.com>
Message-ID: <1392784541-18034-7-git-send-email-vijay.kilari@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>

Add HAVE_ARCH_KGDB for arm64 Kconfig

Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 27bbcfc..02107f2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -38,6 +38,7 @@ config ARM64
 	select HAVE_MEMBLOCK
 	select HAVE_PATA_PLATFORM
 	select HAVE_PERF_EVENTS
+	select HAVE_ARCH_KGDB
 	select IRQ_DOMAIN
 	select MODULES_USE_ELF_RELA
 	select NO_BOOTMEM
-- 
1.7.9.5
