From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri,  4 Oct 2013 21:03:37 +0200
Subject: [PATCH v3 1/3] ARM: pull in <asm/simd.h> from asm-generic
In-Reply-To: <1380913419-13296-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1380913419-13296-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1380913419-13296-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/include/asm/Kbuild | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index d3db398..6577b8a 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -24,6 +24,7 @@ generic-y += sembuf.h
 generic-y += serial.h
 generic-y += shmbuf.h
 generic-y += siginfo.h
+generic-y += simd.h
 generic-y += sizes.h
 generic-y += socket.h
 generic-y += sockios.h
-- 
1.8.1.2
