From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 18 Jul 2016 11:20:54 +0100
Subject: [PATCH] arm64: ptrace: remove extra define for CPSR's E bit
Message-ID: <1468837254-44344-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

...and do not confuse source navigation tools ;)

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/ptrace.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 7f94755..c930f1f 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -46,7 +46,6 @@
 #define COMPAT_PSR_MODE_UND	0x0000001b
 #define COMPAT_PSR_MODE_SYS	0x0000001f
 #define COMPAT_PSR_T_BIT	0x00000020
-#define COMPAT_PSR_E_BIT	0x00000200
 #define COMPAT_PSR_F_BIT	0x00000040
 #define COMPAT_PSR_I_BIT	0x00000080
 #define COMPAT_PSR_A_BIT	0x00000100
-- 
1.7.9.5
