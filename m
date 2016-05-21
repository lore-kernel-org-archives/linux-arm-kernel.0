From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:49:05 +0200
Subject: [PATCH 0095/1529] Fix typo
Message-ID: <20160521114905.4276-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-gemini/idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-gemini/idle.c b/arch/arm/mach-gemini/idle.c
index ddf8ec9..cb34fe4e 100644
--- a/arch/arm/mach-gemini/idle.c
+++ b/arch/arm/mach-gemini/idle.c
@@ -10,7 +10,7 @@ static void gemini_idle(void)
 {
 	/*
 	 * Because of broken hardware we have to enable interrupts or the CPU
-	 * will never wakeup... Acctualy it is not very good to enable
+	 * will never wakeup... Actually it is not very good to enable
 	 * interrupts first since scheduler can miss a tick, but there is
 	 * no other way around this. Platforms that needs it for power saving
 	 * should enable it in init code, since by default it is
-- 
2.8.2.534.g1f66975
