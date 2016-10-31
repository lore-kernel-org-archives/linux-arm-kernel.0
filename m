From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 31 Oct 2016 10:52:53 +0100
Subject: [GIT PULL] ARM: OXNAS SoC updates for 4.10
Message-ID: <1305c61f-b1ef-7caf-7788-67e2b907e873@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  https://github.com/OXNAS/linux.git tags/oxnas-arm-soc-for-4.10

for you to fetch changes up to b3cdb3c5ef514687891f03442f2677850340bcfa:

  ARM: oxnas: Add OX820 config and makefile entry (2016-10-31 10:41:33 +0100)

----------------------------------------------------------------
- Add SMP support for the Oxford Semiconductor OX820 SoC
from http://lkml.kernel.org/r/20161021085848.1754-1-narmstrong at baylibre.com

----------------------------------------------------------------
Neil Armstrong (2):
      ARM: oxnas: Add OX820 SMP support
      ARM: oxnas: Add OX820 config and makefile entry

 arch/arm/Makefile             |   1 +
 arch/arm/mach-oxnas/Kconfig   |  30 +++++++++++++++++++---------
 arch/arm/mach-oxnas/Makefile  |   2 ++
 arch/arm/mach-oxnas/headsmp.S |  28 ++++++++++++++++++++++++++
 arch/arm/mach-oxnas/hotplug.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-oxnas/platsmp.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 267 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/mach-oxnas/Makefile
 create mode 100644 arch/arm/mach-oxnas/headsmp.S
 create mode 100644 arch/arm/mach-oxnas/hotplug.c
 create mode 100644 arch/arm/mach-oxnas/platsmp.c

Thanks,
Neil
