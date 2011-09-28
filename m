From: richardcochran@gmail.com (Richard Cochran)
Date: Wed, 28 Sep 2011 15:16:40 +0200
Subject: [PATCH 0/1] A trio of IXP425 boards
Message-ID: <cover.1317215339.git.richard.cochran@omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for three boards using the ixp425. Since they
are are almost identical to each other, they can share one setup file.

The three machine types are slated for removal due to the fact that
the board support has not been merged. My polite request is to merge
this patch and restore the machine types.

Thanks,
Richard


Richard Cochran (1):
  ixp4xx: support omicron ixp425 based boards

 arch/arm/mach-ixp4xx/Kconfig                   |   19 ++
 arch/arm/mach-ixp4xx/Makefile                  |    4 +
 arch/arm/mach-ixp4xx/include/mach/uncompress.h |    3 +-
 arch/arm/mach-ixp4xx/miccpt-pci.c              |   78 +++++++
 arch/arm/mach-ixp4xx/omixp-setup.c             |  273 ++++++++++++++++++++++++
 5 files changed, 376 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-ixp4xx/miccpt-pci.c
 create mode 100644 arch/arm/mach-ixp4xx/omixp-setup.c

-- 
1.7.2.5
