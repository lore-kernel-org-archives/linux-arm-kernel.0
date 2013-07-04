From: voice.shen@atmel.com (Bo Shen)
Date: Thu,  4 Jul 2013 15:16:40 +0800
Subject: [PATCH 2/4] arm: atmel: include sama5d3.h into hardware.h
In-Reply-To: <1372922202-28606-1-git-send-email-voice.shen@atmel.com>
References: <1372922202-28606-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1372922202-28606-3-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

include sama5d3.h into hardware.h

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 arch/arm/mach-at91/include/mach/hardware.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-at91/include/mach/hardware.h b/arch/arm/mach-at91/include/mach/hardware.h
index a832e07..f17aa31 100644
--- a/arch/arm/mach-at91/include/mach/hardware.h
+++ b/arch/arm/mach-at91/include/mach/hardware.h
@@ -33,6 +33,7 @@
 #include <mach/at91sam9g45.h>
 #include <mach/at91sam9x5.h>
 #include <mach/at91sam9n12.h>
+#include <mach/sama5d3.h>
 
 /*
  * On all at91 except rm9200 and x40 have the System Controller starts
-- 
1.7.9.5
