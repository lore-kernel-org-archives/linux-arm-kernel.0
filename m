From: geoff@infradead.org (Geoff Levand)
Date: Fri, 09 May 2014 00:48:17 +0000
Subject: [PATCH 8/8] arm64: Enable kexec in defconfig
In-Reply-To: <cover.1399594544.git.geoff@infradead.org>
References: <cover.1399594544.git.geoff@infradead.org>
Message-ID: <32399380e2249697ca549848ef83e5706eb4d83c.1399594544.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7959dd0..6ab5f63 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -28,6 +28,7 @@ CONFIG_ARCH_XGENE=y
 CONFIG_SMP=y
 CONFIG_PREEMPT=y
 CONFIG_CMA=y
+CONFIG_KEXEC=y
 CONFIG_CMDLINE="console=ttyAMA0"
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_COMPAT=y
-- 
1.9.1
