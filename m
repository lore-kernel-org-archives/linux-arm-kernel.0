From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Jul 2015 11:42:11 +0100
Subject: [PATCH v2 20/20] arm64: kconfig: select HAVE_CMPXCHG_LOCAL
In-Reply-To: <1437734531-10698-1-git-send-email-will.deacon@arm.com>
References: <1437734531-10698-1-git-send-email-will.deacon@arm.com>
Message-ID: <1437734531-10698-21-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We implement an optimised cmpxchg_local macro, so let the kernel know.

Reviewed-by: Steve Capper <steve.capper@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d11b1af62438..19ea772a5d7b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -53,6 +53,7 @@ config ARM64
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_CC_STACKPROTECTOR
 	select HAVE_CMPXCHG_DOUBLE
+	select HAVE_CMPXCHG_LOCAL
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_API_DEBUG
-- 
2.1.4
