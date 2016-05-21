From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:52:20 +0200
Subject: [PATCH 0123/1529] Fix typo
Message-ID: <20160521115220.5810-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/plat-samsung/include/plat/cpu-freq-core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-samsung/include/plat/cpu-freq-core.h b/arch/arm/plat-samsung/include/plat/cpu-freq-core.h
index 317c523..37cf20e 100644
--- a/arch/arm/plat-samsung/include/plat/cpu-freq-core.h
+++ b/arch/arm/plat-samsung/include/plat/cpu-freq-core.h
@@ -39,7 +39,7 @@ struct s3c2410_iobank_timing {
 	unsigned int	tacs;
 	unsigned int	tcos;
 	unsigned int	tacc;
-	unsigned int	tcoh;		/* nCS hold afrer nOE/nWE */
+	unsigned int	tcoh;		/* nCS hold after nOE/nWE */
 	unsigned int	tcah;		/* Address hold after nCS */
 	unsigned char	nwait_en;	/* nWait enabled for bank. */
 };
-- 
2.8.2.534.g1f66975
