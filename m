From: geoff@infradead.org (Geoff Levand)
Date: Mon, 14 Mar 2016 17:48:01 +0000
Subject: [PATCH v15 19/20] arm64: kdump: enable kdump in the arm64 defconfig
In-Reply-To: <cover.1457977401.git.geoff@infradead.org>
References: <cover.1457977401.git.geoff@infradead.org>
Message-ID: <514118dc2ebf4e391fff5c1cc862daec3643c210.1457977403.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 288cbd6..16bf6dc 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -65,6 +65,7 @@ CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_CMA=y
 CONFIG_XEN=y
 CONFIG_KEXEC=y
+CONFIG_CRASH_DUMP=y
 CONFIG_CMDLINE="console=ttyAMA0"
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_COMPAT=y
-- 
2.5.0
