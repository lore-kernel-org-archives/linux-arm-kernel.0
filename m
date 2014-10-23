From: geoff@infradead.org (Geoff Levand)
Date: Thu, 23 Oct 2014 23:10:59 +0000
Subject: [PATCH 09/10] arm64/kexec: Enable kexec in the arm64 defconfig
In-Reply-To: <cover.1414099246.git.geoff@infradead.org>
References: <cover.1414099246.git.geoff@infradead.org>
Message-ID: <9570f274b9649430b34e5c7e15b63679b94c2c50.1414099246.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d92ef3c..ebf8b3f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -39,6 +39,7 @@ CONFIG_PREEMPT=y
 CONFIG_KSM=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_CMA=y
+CONFIG_KEXEC=y
 CONFIG_CMDLINE="console=ttyAMA0"
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_COMPAT=y
-- 
1.9.1
