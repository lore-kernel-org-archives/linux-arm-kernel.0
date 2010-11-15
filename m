From: mike@compulab.co.il (Mike Rapoport)
Date: Mon, 15 Nov 2010 11:48:31 +0200
Subject: [PATCH v4 0/2] [ARM] Dove: add support for MPP configuration
Message-ID: <cover.1289814287.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add support for multi-purpose pins configuration on Marvell
Dove and enable use of GPIOs 64-71

v4 changes:
* use for loop instead of gotos

v3 changes:
* add convinience macros to improve code readability
* fix pmu_sig_ctrl |= assignment

v2 changes:
* fix group gpio assignment

Mike Rapoport (2):
  [ARM] Dove: add support for GPIOs 64-71
  [ARM] Dove: add support for multi-purpose pins configuration

 arch/arm/mach-dove/Makefile            |    2 +-
 arch/arm/mach-dove/include/mach/dove.h |    9 +-
 arch/arm/mach-dove/include/mach/gpio.h |    6 +-
 arch/arm/mach-dove/mpp.c               |  212 ++++++++++++++++++++++++++++++
 arch/arm/mach-dove/mpp.h               |  220 ++++++++++++++++++++++++++++++++
 5 files changed, 445 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-dove/mpp.c
 create mode 100644 arch/arm/mach-dove/mpp.h

-- 
1.7.3.1
