From: geoff@infradead.org (Geoff Levand)
Date: Thu, 09 Jun 2016 20:08:44 +0000
Subject: [PATCH v18 05/13] arm64/kexec: Enable kexec in the arm64 defconfig
In-Reply-To: <cover.1465502767.git.geoff@infradead.org>
References: <cover.1465502767.git.geoff@infradead.org>
Message-ID: <52e619737f5439b3cec28a4b2d339cbebd7abe83.1465502767.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index fd2d74d..4ed4756 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -70,6 +70,7 @@ CONFIG_KSM=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_CMA=y
 CONFIG_XEN=y
+CONFIG_KEXEC=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_COMPAT=y
 CONFIG_CPU_IDLE=y
-- 
2.5.0
