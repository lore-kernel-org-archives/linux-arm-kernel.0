From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed,  1 Feb 2017 21:46:29 +0900
Subject: [PATCH v31 10/12] arm64: kdump: enable kdump in defconfig
In-Reply-To: <20170201124218.5823-1-takahiro.akashi@linaro.org>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
Message-ID: <20170201124630.6016-9-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kdump is enabled by default as kexec is.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 33b744d54739..94c2ea523a8a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -79,6 +79,7 @@ CONFIG_CMA=y
 CONFIG_SECCOMP=y
 CONFIG_XEN=y
 CONFIG_KEXEC=y
+CONFIG_CRASH_DUMP=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_COMPAT=y
 CONFIG_CPU_IDLE=y
-- 
2.11.0
