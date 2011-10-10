From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 10 Oct 2011 16:11:13 +0200
Subject: [PATCH] arm: mx23: add machine_is_stmp_378x()
Message-ID: <1318255873-17370-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding this line was forgotten when converting mach-stmp378x to
mach-mxs.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/arm/mach-mxs/include/mach/mxs.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/include/mach/mxs.h b/arch/arm/mach-mxs/include/mach/mxs.h
index 35a89dd..1332f73 100644
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
1.7.6.3
