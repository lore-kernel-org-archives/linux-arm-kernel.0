From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed,  2 Nov 2016 13:52:48 +0900
Subject: [PATCH v27 7/9] arm64: kdump: enable kdump in defconfig
In-Reply-To: <20161102044959.11954-1-takahiro.akashi@linaro.org>
References: <20161102044959.11954-1-takahiro.akashi@linaro.org>
Message-ID: <20161102045249.12058-6-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kdump is enabled by default as kexec is.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index dab2cb0..24922c9 100644
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
2.10.0
