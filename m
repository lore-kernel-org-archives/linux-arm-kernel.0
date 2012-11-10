From: keescook@chromium.org (Kees Cook)
Date: Sat, 10 Nov 2012 14:44:45 -0800
Subject: [PATCH 4/4] arch/arm: select HAVE_ARCH_SECCOMP_FILTER
In-Reply-To: <1352587485-18348-1-git-send-email-keescook@chromium.org>
References: <1352587485-18348-1-git-send-email-keescook@chromium.org>
Message-ID: <1352587485-18348-5-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Drewry <wad@chromium.org>

Reflect architectural support for seccomp filter.

Signed-off-by: Will Drewry <wad@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ade7e92..0e8d490 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -21,6 +21,7 @@ config ARM
 	select HAVE_AOUT
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
 	select HAVE_ARCH_KGDB
+	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_BPF_JIT
 	select HAVE_C_RECORDMCOUNT
-- 
1.7.9.5
