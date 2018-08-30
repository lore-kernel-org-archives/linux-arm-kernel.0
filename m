From: will.deacon@arm.com (Will Deacon)
Date: Thu, 30 Aug 2018 17:16:01 +0100
Subject: [PATCH 1/7] arm64: Fix silly typo in comment
In-Reply-To: <1535645767-9901-1-git-send-email-will.deacon@arm.com>
References: <1535645767-9901-1-git-send-email-will.deacon@arm.com>
Message-ID: <1535645767-9901-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I was passing through and figuered I'd fix this up:

	featuer -> feature

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 1717ba1db35d..9079715794af 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -262,7 +262,7 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
 /*
  * CPU feature detected at boot time based on system-wide value of a
  * feature. It is safe for a late CPU to have this feature even though
- * the system hasn't enabled it, although the featuer will not be used
+ * the system hasn't enabled it, although the feature will not be used
  * by Linux in this case. If the system has enabled this feature already,
  * then every late CPU must have it.
  */
-- 
2.1.4
