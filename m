From: geoff@infradead.org (Geoff Levand)
Date: Fri, 14 Nov 2014 01:22:16 +0000
Subject: [PATCH 8/8] arm64/kexec: Enable kexec in the arm64 defconfig
In-Reply-To: <cover.1415926876.git.geoff@infradead.org>
References: <cover.1415926876.git.geoff@infradead.org>
Message-ID: <3fc5a4ba22342ccd8e7e5a09620b00f4b81667a6.1415926876.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4ce602c..6a8f02a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -40,6 +40,7 @@ CONFIG_PREEMPT=y
 CONFIG_KSM=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_CMA=y
+CONFIG_KEXEC=y
 CONFIG_CMDLINE="console=ttyAMA0"
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_COMPAT=y
-- 
1.9.1
