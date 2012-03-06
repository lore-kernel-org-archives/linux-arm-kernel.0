From: will.deacon@arm.com (Will Deacon)
Date: Tue,  6 Mar 2012 16:54:03 +0000
Subject: [PATCH 3/6] ARM: nommu: fix typo in mm/Kconfig
In-Reply-To: <1331052846-19144-1-git-send-email-will.deacon@arm.com>
References: <1331052846-19144-1-git-send-email-will.deacon@arm.com>
Message-ID: <1331052846-19144-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The description for the CPU_HIGH_VECTOR Kconfig option for nommu builds
doesn't make any sense.

This patch fixes up the trivial grammatical error.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 7edef91..7c8a7d8 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -723,7 +723,7 @@ config CPU_HIGH_VECTOR
 	bool "Select the High exception vector"
 	help
 	  Say Y here to select high exception vector(0xFFFF0000~).
-	  The exception vector can be vary depending on the platform
+	  The exception vector can vary depending on the platform
 	  design in nommu mode. If your platform needs to select
 	  high exception vector, say Y.
 	  Otherwise or if you are unsure, say N, and the low exception
-- 
1.7.4.1
