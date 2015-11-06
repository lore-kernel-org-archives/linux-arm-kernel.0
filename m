From: geoff@infradead.org (Geoff Levand)
Date: Fri, 06 Nov 2015 19:14:36 +0000
Subject: [PATCH 09/15] arm64/kexec: Enable kexec in the arm64 defconfig
In-Reply-To: <cover.1446836442.git.geoff@infradead.org>
References: <cover.1446836442.git.geoff@infradead.org>
Message-ID: <6f8984b79b37443289956108f7ce668d69d713f2.1446836443.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 34d71dd..c80d8a4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -55,6 +55,7 @@ CONFIG_PREEMPT=y
 CONFIG_KSM=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_CMA=y
+CONFIG_KEXEC=y
 CONFIG_CMDLINE="console=ttyAMA0"
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_COMPAT=y
-- 
2.5.0
