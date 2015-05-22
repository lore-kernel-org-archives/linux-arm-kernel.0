From: lho@apm.com (Loc Ho)
Date: Fri, 22 May 2015 17:32:56 -0600
Subject: [PATCH v11 1/5] arm64: Enable EDAC on ARM64
In-Reply-To: <1432337580-3750-1-git-send-email-lho@apm.com>
References: <1432337580-3750-1-git-send-email-lho@apm.com>
Message-ID: <1432337580-3750-2-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select EDAC_SUPPORT for arm64.

Signed-off-by: Loc Ho <lho@apm.com>
---
 arch/arm64/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4269dba..577078f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -22,6 +22,7 @@ config ARM64
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
 	select COMMON_CLK
+	select EDAC_SUPPORT
 	select CPU_PM if (SUSPEND || CPU_IDLE)
 	select DCACHE_WORD_ACCESS
 	select GENERIC_ALLOCATOR
-- 
1.7.1
