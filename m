From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Wed, 21 May 2014 17:57:04 +0300
Subject: [PATCH v1 3/4] ARM: qcom: Add APQ8084-MTP board to mach-qcom
In-Reply-To: <1400684225-21381-1-git-send-email-gdjakov@mm-sol.com>
References: <1400684225-21381-1-git-send-email-gdjakov@mm-sol.com>
Message-ID: <1400684225-21381-4-git-send-email-gdjakov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add board compatibility string to the board machine descriptors.

Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
---
 arch/arm/mach-qcom/board.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-qcom/board.c b/arch/arm/mach-qcom/board.c
index bae617e..ae0a405 100644
--- a/arch/arm/mach-qcom/board.c
+++ b/arch/arm/mach-qcom/board.c
@@ -18,6 +18,7 @@ static const char * const qcom_dt_match[] __initconst = {
 	"qcom,msm8660-surf",
 	"qcom,msm8960-cdp",
 	"qcom,apq8074-dragonboard",
+	"qcom,apq8084-mtp",
 	NULL
 };
 
-- 
1.7.9.5
