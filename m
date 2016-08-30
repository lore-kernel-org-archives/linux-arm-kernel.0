From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 30 Aug 2016 15:53:08 +0900
Subject: [PATCH v25] 7/9] arm64: kdump: enable kdump in the arm64 defconfig
In-Reply-To: <20160830064941.19452-2-takahiro.akashi@linaro.org>
References: <20160830064941.19452-2-takahiro.akashi@linaro.org>
Message-ID: <20160830065309.19604-5-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index eadf485..e181132 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -77,6 +77,7 @@ CONFIG_CMA=y
 CONFIG_SECCOMP=y
 CONFIG_XEN=y
 CONFIG_KEXEC=y
+CONFIG_CRASH_DUMP=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_COMPAT=y
 CONFIG_CPU_IDLE=y
-- 
2.9.0
