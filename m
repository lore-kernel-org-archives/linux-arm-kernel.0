From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 18 Mar 2014 12:44:22 +0100
Subject: [PATCH RFT 1/2] ARM64: pull in <asm/simd.h> from asm-generic
In-Reply-To: <1395143063-28897-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1395143063-28897-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1395143063-28897-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/Kbuild | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 71c53ecfcc3a..43a2c9d2d6f4 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -35,6 +35,7 @@ generic-y += segment.h
 generic-y += sembuf.h
 generic-y += serial.h
 generic-y += shmbuf.h
+generic-y += simd.h
 generic-y += sizes.h
 generic-y += socket.h
 generic-y += sockios.h
-- 
1.8.3.2
