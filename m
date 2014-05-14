From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 14 May 2014 11:17:26 -0700
Subject: [PATCH v2 06/11] arm64: pull in <asm/simd.h> from asm-generic
In-Reply-To: <1400091451-9117-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1400091451-9117-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1400091451-9117-7-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/Kbuild | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 83f71b3004a8..42c7eecd2bb6 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -40,6 +40,7 @@ generic-y += segment.h
 generic-y += sembuf.h
 generic-y += serial.h
 generic-y += shmbuf.h
+generic-y += simd.h
 generic-y += sizes.h
 generic-y += socket.h
 generic-y += sockios.h
-- 
1.8.3.2
