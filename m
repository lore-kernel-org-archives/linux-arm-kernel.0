From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 22 Sep 2013 18:43:35 +0200
Subject: [PATCH] ARM: drop <asm/types.h> from generic-y
Message-ID: <1379868215-15270-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 09096f6 introduced an ARM specific <asm/types.h> to work
around some ambiguities in the definitions of 32 bit types.
Hence, we will not be needing the generic version anymore.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/include/asm/Kbuild | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index d3db398..59ceae8 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -31,5 +31,4 @@ generic-y += termbits.h
 generic-y += termios.h
 generic-y += timex.h
 generic-y += trace_clock.h
-generic-y += types.h
 generic-y += unaligned.h
-- 
1.8.1.2
