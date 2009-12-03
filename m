From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 03 Dec 2009 16:01:23 +0000
Subject: Please pull next-plat-samsung
Message-ID: <E1NGE7P-000790-8U@teyla.home.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 648f4e3e50c4793d9dbf9a09afa193631f76fa26:
  Linus Torvalds (1):
        Linux 2.6.32-rc8

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git next-plat-samsung

Ben Dooks (1):
      ARM: SAMSUNG: Add plat-samsung as starting point for plat-s3c* moves

 arch/arm/Kconfig               |    1 +
 arch/arm/Makefile              |    6 +++---
 arch/arm/plat-samsung/Kconfig  |   17 +++++++++++++++++
 arch/arm/plat-samsung/Makefile |   11 +++++++++++
 4 files changed, 32 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/plat-samsung/Kconfig
 create mode 100644 arch/arm/plat-samsung/Makefile
