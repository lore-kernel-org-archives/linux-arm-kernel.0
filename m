From: richardcochran@gmail.com (Richard Cochran)
Date: Wed, 2 Jun 2010 11:55:58 +0200
Subject: [PATCH 0/3] Support for three IXP425 based boards
Message-ID: <cover.1275415521.git.richard.cochran@omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for three IXP425 based boards from
OMICRON electronics GmbH. The code has been adapted from the IXDP425
and the NSLU boards.

Richard Cochran (3):
  ixp4xx: support the OMICRON DEVIXP board
  ixp4xx: support the OMICRON MICCPT board
  ixp4xx: support the OMICRON MIC256 board

 arch/arm/mach-ixp4xx/Kconfig                   |   22 +++
 arch/arm/mach-ixp4xx/Makefile                  |    4 +
 arch/arm/mach-ixp4xx/devixp-setup.c            |  225 ++++++++++++++++++++++++
 arch/arm/mach-ixp4xx/include/mach/uncompress.h |    3 +-
 arch/arm/mach-ixp4xx/mic256-setup.c            |  220 +++++++++++++++++++++++
 arch/arm/mach-ixp4xx/miccpt-pci.c              |   78 ++++++++
 arch/arm/mach-ixp4xx/miccpt-setup.c            |  221 +++++++++++++++++++++++
 7 files changed, 772 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-ixp4xx/devixp-setup.c
 create mode 100644 arch/arm/mach-ixp4xx/mic256-setup.c
 create mode 100644 arch/arm/mach-ixp4xx/miccpt-pci.c
 create mode 100644 arch/arm/mach-ixp4xx/miccpt-setup.c
