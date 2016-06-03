From: geoff@infradead.org (Geoff Levand)
Date: Fri, 03 Jun 2016 18:13:41 +0000
Subject: [PATCH v17 11/13] arm64: kdump: enable kdump in the arm64 defconfig
In-Reply-To: <cover.1464974516.git.geoff@infradead.org>
References: <cover.1464974516.git.geoff@infradead.org>
Message-ID: <e23222de12e46e84790f55665fbe8b2f6fb0eb54.1464974516.git.geoff@infradead.org>
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
