From: jvial@adeneo-embedded.com (Jeremy Vial)
Date: Thu, 31 Jul 2014 15:10:32 +0200
Subject: [PATCH 0/2] Manage OMAP34xx ES3.1.2 rev to resume from suspend
Message-ID: <1406812234-23163-1-git-send-email-jvial@adeneo-embedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

My kernel crashed when my OMAP34xx ES3.1.2 leave suspend mode. The first
patch seems to solve the issue, and the second one corrects Linux kernel
coding style problems.

Jeremy Vial (2):
  ARM: OMAP3: Fix choice of omap3_restore_es function in OMAP34XX
    rev3.1.2 case.
  ARM: OMAP3: Fix coding style problems in
    arch/arm/mach-omap2/control.c

 arch/arm/mach-omap2/control.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
1.7.9.5
