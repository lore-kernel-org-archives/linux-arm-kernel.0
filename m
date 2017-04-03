From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon,  3 Apr 2017 11:24:39 +0900
Subject: [PATCH v35 11/14] arm64: kdump: enable kdump in defconfig
In-Reply-To: <20170403022139.12383-1-takahiro.akashi@linaro.org>
References: <20170403022139.12383-1-takahiro.akashi@linaro.org>
Message-ID: <20170403022440.12515-9-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kdump is enabled by default as kexec is.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7c48028ec64a..927ee18bbdf2 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -82,6 +82,7 @@ CONFIG_CMA=y
 CONFIG_SECCOMP=y
 CONFIG_XEN=y
 CONFIG_KEXEC=y
+CONFIG_CRASH_DUMP=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_COMPAT=y
 CONFIG_CPU_IDLE=y
-- 
2.11.1
