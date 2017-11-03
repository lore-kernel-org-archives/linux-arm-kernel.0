From: samitolvanen@google.com (Sami Tolvanen)
Date: Fri,  3 Nov 2017 10:12:03 -0700
Subject: [PATCH 15/15] arm64: select ARCH_SUPPORTS_CLANG_LTO
In-Reply-To: <20171103171203.107569-1-samitolvanen@google.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
Message-ID: <20171103171203.107569-20-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow CONFIG_CLANG_LTO to be enabled for the architecture.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a301fdc90319..6ae31f0c58ee 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -23,6 +23,7 @@ config ARM64
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if ACPI_APEI_SEA
 	select ARCH_USE_CMPXCHG_LOCKREF
+	select ARCH_SUPPORTS_CLANG_LTO
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_NUMA_BALANCING
-- 
2.15.0.403.gc27cc4dac6-goog
