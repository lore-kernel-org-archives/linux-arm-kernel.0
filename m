From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 13 Aug 2015 12:33:57 +0100
Subject: [PATCH 07/14] arm64: Kconfig: Fix help text about AArch32 support
 with 64K pages
In-Reply-To: <1439465645-22584-1-git-send-email-suzuki.poulose@arm.com>
References: <1439465645-22584-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1439465645-22584-8-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

Update the help text for ARM64_64K_PAGES to reflect the reality
about AArch32 support.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d1fb2a3..b247897 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -449,8 +449,8 @@ config ARM64_64K_PAGES
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
