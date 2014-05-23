From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Fri, 23 May 2014 18:12:31 +0300
Subject: [PATCH v2 3/4] ARM: qcom: Add APQ8084 to mach-qcom
In-Reply-To: <1400857952-6963-1-git-send-email-gdjakov@mm-sol.com>
References: <1400857952-6963-1-git-send-email-gdjakov@mm-sol.com>
Message-ID: <1400857952-6963-4-git-send-email-gdjakov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the SoC compatibility string to the board machine descriptors.

Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
---
 arch/arm/mach-qcom/board.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-qcom/board.c b/arch/arm/mach-qcom/board.c
index bae617e..c17e7b0 100644
--- a/arch/arm/mach-qcom/board.c
+++ b/arch/arm/mach-qcom/board.c
@@ -18,6 +18,7 @@ static const char * const qcom_dt_match[] __initconst = {
 	"qcom,msm8660-surf",
 	"qcom,msm8960-cdp",
 	"qcom,apq8074-dragonboard",
+	"qcom,apq8084",
 	NULL
 };
 
-- 
1.7.9.5
