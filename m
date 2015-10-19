From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 19 Oct 2015 14:19:34 +0100
Subject: [PATCHv4 08/12] arm64: Kconfig: Fix help text about AArch32 support
 with 64K pages
In-Reply-To: <1445260779-22242-1-git-send-email-suzuki.poulose@arm.com>
References: <1445260779-22242-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1445260779-22242-9-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the help text for ARM64_64K_PAGES to reflect the reality
about AArch32 support.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4654c27..13b51a0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -368,8 +368,8 @@ config ARM64_64K_PAGES
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
