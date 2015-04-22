From: jonathar@broadcom.com (Jonathan Richardson)
Date: Wed, 22 Apr 2015 16:22:01 -0700
Subject: [PATCH 0/2] Add DTE driver for Cygnus
Message-ID: <1429744923-2007-1-git-send-email-jonathar@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset includes the Digital Timing Engine (DTE) driver for Cygnus SoC's.

Jonathan Richardson (2):
  misc: Add DT binding for cygnus Digital Timing Engine (DTE) driver.
  misc: Add initial Digital Timing Engine (DTE) driver for cygnus

 .../bindings/arm/bcm/brcm,cygnus-dte.txt           |   24 +
 drivers/misc/Kconfig                               |   11 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/bcm_cygnus_dte.c                      |  927 ++++++++++++++++++++
 include/linux/bcm_cygnus_dte.h                     |   99 +++
 5 files changed, 1062 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,cygnus-dte.txt
 create mode 100644 drivers/misc/bcm_cygnus_dte.c
 create mode 100644 include/linux/bcm_cygnus_dte.h

-- 
1.7.9.5
