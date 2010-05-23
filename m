From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sun, 23 May 2010 21:55:42 +0200
Subject: [PATCH 133/199] arch/arm/boot/bootp/bootp.lds: Checkpatch cleanup
In-Reply-To: <1274644549-24952-1-git-send-email-andrea.gelmini@gelma.net>
References: <1274644549-24952-1-git-send-email-andrea.gelmini@gelma.net>
Message-ID: <1274644549-24952-6-git-send-email-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/boot/bootp/bootp.lds:22: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/boot/bootp/bootp.lds |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/bootp/bootp.lds b/arch/arm/boot/bootp/bootp.lds
index 8e3d81c..fc54394 100644
--- a/arch/arm/boot/bootp/bootp.lds
+++ b/arch/arm/boot/bootp/bootp.lds
@@ -19,7 +19,7 @@ SECTIONS
    initrd_size = initrd_end - initrd_start;
    _etext = .;
   }
-  
+
   .stab 0 : { *(.stab) }
   .stabstr 0 : { *(.stabstr) }
   .stab.excl 0 : { *(.stab.excl) }
-- 
1.7.1.251.gf80a2
