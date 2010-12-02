From: h-kanigeri2@ti.com (Kanigeri, Hari)
Date: Thu, 2 Dec 2010 06:07:23 -0600
Subject: [GIT PULL] OMAP: mailbox and iommu changes: for-next for v2.6.38
Message-ID: <AANLkTind+DH5emar2L9EiV-pqpCvQHQGnFevh9Bncrpz@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

The following changes since commit e8a7e48bb248a1196484d3f8afa53bded2b24e71:
  Linus Torvalds (1):
        Linux 2.6.37-rc4

are available in the git repository at:

  git://gitorious.org/iommu_mailbox/iommu_mailbox.git for_2.6.38

Fernando Guzman Lugo (5):
      OMAP: mailbox: change full flag per mailbox queue instead of global
      omap: iovmm - no gap checking for fixed address
      omap: iovmm - add superpages support to fixed da address
      omap: iovmm - replace __iounmap with omap_iounmap
      omap: iommu - create new api to set valid da range

Kanigeri, Hari (3):
      OMAP: mailbox: fix checkpatch warnings
      OMAP: mailbox: send message in process context
      OMAP: mailbox: add notification support for multiple readers

Omar Ramirez Luna (2):
      OMAP: mailbox: remove unreachable return
      OMAP: mailbox: fix detection for previously supported chips

 arch/arm/mach-omap2/mailbox.c             |   19 +++--
 arch/arm/plat-omap/include/plat/iommu.h   |    3 +
 arch/arm/plat-omap/include/plat/mailbox.h |    8 +-
 arch/arm/plat-omap/iommu.c                |   33 +++++++
 arch/arm/plat-omap/iovmm.c                |   84 +++++++++++--------
 arch/arm/plat-omap/mailbox.c              |  130 +++++++++++++++++------------
 6 files changed, 177 insertions(+), 100 deletions(-)

Thank you,
Best regards,
Hari Kanigeri
