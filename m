From: geoff@infradead.org (Geoff Levand)
Date: Sat, 17 Jan 2015 00:23:34 +0000
Subject: [PATCH 8/8] arm64/kexec: Enable kexec in the arm64 defconfig
In-Reply-To: <cover.1421449714.git.geoff@infradead.org>
References: <cover.1421449714.git.geoff@infradead.org>
Message-ID: <7db998d9533d5efab816edfad3d7010fc2f7e62c.1421449714.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5376d90..85285dc 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -42,6 +42,7 @@ CONFIG_PREEMPT=y
 CONFIG_KSM=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_CMA=y
+CONFIG_KEXEC=y
 CONFIG_CMDLINE="console=ttyAMA0"
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_COMPAT=y
-- 
2.1.0
