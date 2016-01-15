From: geoff@infradead.org (Geoff Levand)
Date: Fri, 15 Jan 2016 19:18:38 +0000
Subject: [PATCH 17/19] arm64: kdump: enable kdump in the arm64 defconfig
In-Reply-To: <cover.1452884156.git.geoff@infradead.org>
References: <cover.1452884156.git.geoff@infradead.org>
Message-ID: <63a1156223f2c1480b436a1587a94e6eee384fa9.1452884156.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0470fdf..6dc3d00 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -59,6 +59,7 @@ CONFIG_KSM=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_CMA=y
 CONFIG_KEXEC=y
+CONFIG_CRASH_DUMP=y
 CONFIG_CMDLINE="console=ttyAMA0"
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_COMPAT=y
-- 
2.5.0
