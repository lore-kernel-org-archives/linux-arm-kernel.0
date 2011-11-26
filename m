From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 26 Nov 2011 11:39:14 +0100
Subject: [PATCH] arm: mx23: recognise stmp378x as mx23
Message-ID: <1322303955-9225-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding the machine_is_* line was forgotten when converting mach-stmp378x to
mach-mxs.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/arm/mach-mxs/include/mach/mxs.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/include/mach/mxs.h b/arch/arm/mach-mxs/include/mach/mxs.h
index 0d2d2b4..bde5f66 100644
--- a/arch/arm/mach-mxs/include/mach/mxs.h
+++ b/arch/arm/mach-mxs/include/mach/mxs.h
@@ -30,6 +30,7 @@
  */
 #define cpu_is_mx23()		(					\
 		machine_is_mx23evk() ||					\
+		machine_is_stmp378x() ||				\
 		0)
 #define cpu_is_mx28()		(					\
 		machine_is_mx28evk() ||					\
-- 
1.7.7.2
