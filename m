From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 12 Jul 2016 14:05:12 +0900
Subject: [PATCH v22 6/8] arm64: kdump: enable kdump in the arm64 defconfig
In-Reply-To: <20160712050514.22307-1-takahiro.akashi@linaro.org>
References: <20160712050514.22307-1-takahiro.akashi@linaro.org>
Message-ID: <20160712050514.22307-7-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
2.9.0
