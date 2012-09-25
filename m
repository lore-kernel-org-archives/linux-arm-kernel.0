From: linux@prisktech.co.nz (Tony Prisk)
Date: Wed, 26 Sep 2012 05:47:18 +1200
Subject: [PATCH] Fixup for v3.7
Message-ID: <1348595239-30577-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof: Could you apply this patch by hand? Fixes a compile-time error in
v3.7 which prevents building vt8500 since gpio.h was removed as part
of the multiplatform update.

Tony Prisk (1):
  arm: vt8500: Fixup for missing gpio.h

 arch/arm/mach-vt8500/vt8500.c |    1 -
 1 file changed, 1 deletion(-)

-- 
1.7.9.5
