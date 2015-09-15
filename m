From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 15 Sep 2015 16:41:16 +0100
Subject: [PATCH 07/15] arm64: Kconfig: Fix help text about AArch32 support
 with 64K pages
In-Reply-To: <1442331684-28818-1-git-send-email-suzuki.poulose@arm.com>
References: <1442331684-28818-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1442331684-28818-8-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

Update the help text for ARM64_64K_PAGES to reflect the reality
about AArch32 support.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ab0a36f..83bca48 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -350,8 +350,8 @@ config ARM64_64K_PAGES
 	help
 	  This feature enables 64KB pages support (4KB by default)
 	  allowing only two levels of page tables and faster TLB
-	  look-up. AArch32 emulation is not available when this feature
-	  is enabled.
+	  look-up. AArch32 emulation requires applications compiled
+	  with 64K aligned segments.
 
 endchoice
 
-- 
1.7.9.5
