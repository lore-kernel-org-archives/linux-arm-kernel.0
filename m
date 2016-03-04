From: geoff@infradead.org (Geoff Levand)
Date: Fri, 04 Mar 2016 23:51:15 +0000
Subject: [PATCH v14 13/20] arm64/kexec: Enable kexec in the arm64 defconfig
In-Reply-To: <cover.1457135058.git.geoff@infradead.org>
References: <cover.1457135058.git.geoff@infradead.org>
Message-ID: <b1f3b2664006ec06c3def2e19e4f666fde3f1ea5.1457135058.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 86581f7..288cbd6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -64,6 +64,7 @@ CONFIG_KSM=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_CMA=y
 CONFIG_XEN=y
+CONFIG_KEXEC=y
 CONFIG_CMDLINE="console=ttyAMA0"
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_COMPAT=y
-- 
2.5.0
