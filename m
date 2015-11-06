From: geoff@infradead.org (Geoff Levand)
Date: Fri, 06 Nov 2015 19:14:37 +0000
Subject: [PATCH 14/15] arm64: kdump: enable kdump in the arm64 defconfig
In-Reply-To: <cover.1446836442.git.geoff@infradead.org>
References: <cover.1446836442.git.geoff@infradead.org>
Message-ID: <f31a8d8540a13d69dc851eda2461ca823cc0e2c9.1446836443.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c80d8a4..94ec44e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -56,6 +56,7 @@ CONFIG_KSM=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_CMA=y
 CONFIG_KEXEC=y
+CONFIG_CRASH_DUMP=y
 CONFIG_CMDLINE="console=ttyAMA0"
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_COMPAT=y
-- 
2.5.0
