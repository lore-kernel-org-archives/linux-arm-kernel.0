From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri, 25 Mar 2011 09:28:54 -0600
Subject: [PATCH 1/8] ux500: adding machine ID for snowball.
In-Reply-To: <1301066941-15877-1-git-send-email-mathieu.poirier@linaro.org>
References: <1301066941-15877-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1301066941-15877-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu J. Poirier <mathieu.poirier@linaro.org>

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/arm/tools/mach-types |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index 9d6feaa..e9f780e 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -3316,3 +3316,4 @@ rover_g8		MACH_ROVER_G8		ROVER_G8		3335
 t5388p			MACH_T5388P		T5388P			3336
 dingo			MACH_DINGO		DINGO			3337
 goflexhome		MACH_GOFLEXHOME		GOFLEXHOME		3338
+snowball		MACH_U8500_SNOWBALL	SNOWBALL		3363
-- 
1.7.1
