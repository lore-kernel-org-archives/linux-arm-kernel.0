From: geoff@infradead.org (Geoff Levand)
Date: Tue, 24 Nov 2015 22:25:34 +0000
Subject: [PATCH v12 10/16] arm64/kexec: Enable kexec in the arm64 defconfig
In-Reply-To: <cover.1448403503.git.geoff@infradead.org>
References: <cover.1448403503.git.geoff@infradead.org>
Message-ID: <9e472e0f63d4e436c46f76c6dfddacc35153b7c6.1448403503.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index bdd7aa3..0470fdf 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -58,6 +58,7 @@ CONFIG_PREEMPT=y
 CONFIG_KSM=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_CMA=y
+CONFIG_KEXEC=y
 CONFIG_CMDLINE="console=ttyAMA0"
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_COMPAT=y
-- 
2.5.0
