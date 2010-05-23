From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sun, 23 May 2010 21:55:49 +0200
Subject: [PATCH 140/199] arch/arm/nwfpe/fpsr.h: Checkpatch cleanup
In-Reply-To: <1274644549-24952-1-git-send-email-andrea.gelmini@gelma.net>
References: <1274644549-24952-1-git-send-email-andrea.gelmini@gelma.net>
Message-ID: <1274644549-24952-13-git-send-email-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/nwfpe/fpsr.h:33: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/nwfpe/fpsr.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/nwfpe/fpsr.h b/arch/arm/nwfpe/fpsr.h
index 859b300..bd425dc 100644
--- a/arch/arm/nwfpe/fpsr.h
+++ b/arch/arm/nwfpe/fpsr.h
@@ -30,7 +30,7 @@ one byte.
 	EXCEPTION TRAP ENABLE BYTE
 	SYSTEM CONTROL BYTE
 	CUMULATIVE EXCEPTION FLAGS BYTE
-	
+
 The FPCR is a 32 bit register consisting of bit flags.
 */
 
-- 
1.7.1.251.gf80a2
