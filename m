From: geoff@infradead.org (Geoff Levand)
Date: Mon, 10 Oct 2016 21:22:59 +0000
Subject: [PATCH 2/2] arm64: Add missing kexec dist files
In-Reply-To: <cover.1476134309.git.geoff@infradead.org>
References: <cover.1476134309.git.geoff@infradead.org>
Message-ID: <3552a3e85a910688d932535549b35354a54927ad.1476134309.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 kexec/arch/arm64/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kexec/arch/arm64/Makefile b/kexec/arch/arm64/Makefile
index d729df8..74b677f 100644
--- a/kexec/arch/arm64/Makefile
+++ b/kexec/arch/arm64/Makefile
@@ -20,7 +20,9 @@ arm64_VIRT_TO_PHYS =
 arm64_PHYS_TO_VIRT =
 
 dist += $(arm64_KEXEC_SRCS) \
+	kexec/arch/arm64/include/arch/options.h \
 	kexec/arch/arm64/crashdump-arm64.h \
+	kexec/arch/arm64/image-header.h \
 	kexec/arch/arm64/kexec-arm64.h \
 	kexec/arch/arm64/Makefile
 
-- 
2.7.4
