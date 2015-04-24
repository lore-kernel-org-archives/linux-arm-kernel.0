From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 24 Apr 2015 16:53:08 +0900
Subject: [v2 5/5] arm64: enable kdump in the arm64 defconfig
In-Reply-To: <1429861989-8417-1-git-send-email-takahiro.akashi@linaro.org>
References: <1429861989-8417-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1429861989-8417-6-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/configs/defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 583cacb..7b3fa3a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -49,6 +49,7 @@ CONFIG_KSM=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_CMA=y
 CONFIG_KEXEC=y
+CONFIG_CRASH_DUMP=y
 CONFIG_CMDLINE="console=ttyAMA0"
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_COMPAT=y
-- 
1.7.9.5
