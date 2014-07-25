From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 25 Jul 2014 16:09:48 +0800
Subject: [PATCH v2 0/2] Enable SCU standby support at core level
Message-ID: <1406275790-18617-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
 - Check earlier revsions of Cortex-A9 and skip setting standby bit
 - Drop i.MX platform patch, which will be handled after core change
   gets accepted

Shawn Guo (2):
  ARM: smp_scu: use macro for SCU enable bit
  ARM: smp_scu: enable SCU standby support

 arch/arm/kernel/smp_scu.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
1.9.1
