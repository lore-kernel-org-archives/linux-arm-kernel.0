From: mike@compulab.co.il (Mike Rapoport)
Date: Wed, 27 Oct 2010 14:24:49 +0200
Subject: [PATCH v2 0/2] Dove: add support for MPP configuration
Message-ID: <cover.1288181065.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add support for multi-purpose pins configuration on Marvell
Dove and enable use of GPIOs 64-71

v2 changes:
* fix group gpio assignment

Mike Rapoport (2):
  [ARM] Dove: add support for GPIOs 64-71
  [ARM] Dove: add support for multi-purpose pins configuration

 arch/arm/mach-dove/Makefile            |    2 +-
 arch/arm/mach-dove/include/mach/dove.h |    9 ++-
 arch/arm/mach-dove/include/mach/gpio.h |    6 +-
 arch/arm/mach-dove/mpp.c               |  215 ++++++++++++++++++++++++++++++++
 arch/arm/mach-dove/mpp.h               |  214 +++++++++++++++++++++++++++++++
 5 files changed, 442 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-dove/mpp.c
 create mode 100644 arch/arm/mach-dove/mpp.h

-- 
1.7.3.1
