From: geoff@infradead.org (Geoff Levand)
Date: Thu, 09 Jun 2016 20:08:45 +0000
Subject: [PATCH v18 11/13] arm64: kdump: enable kdump in the arm64 defconfig
In-Reply-To: <cover.1465502767.git.geoff@infradead.org>
References: <cover.1465502767.git.geoff@infradead.org>
Message-ID: <3e14e9031007a4df78098e5caf597b8d013f15f7.1465502767.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4ed4756..aa3e1dd 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -71,6 +71,7 @@ CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_CMA=y
 CONFIG_XEN=y
 CONFIG_KEXEC=y
+CONFIG_CRASH_DUMP=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_COMPAT=y
 CONFIG_CPU_IDLE=y
-- 
2.5.0
