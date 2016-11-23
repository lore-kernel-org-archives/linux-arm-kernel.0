From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 23 Nov 2016 10:01:08 +0100
Subject: [GIT PULL v2] ARM: OXNAS SoC updates for 4.10
Message-ID: <55c31b07-ae4e-5bb3-3576-b597805c009d@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  https://github.com/OXNAS/linux.git tags/oxnas-arm-soc-for-4.10-v2

for you to fetch changes up to e330ea5e8cea7ba58f0ba9d40063b13cf8639555:

  ARM: oxnas: Add OX820 config and makefile entry (2016-11-23 09:53:55 +0100)

----------------------------------------------------------------
- Add SMP support for the Oxford Semiconductor OX820 SoC
from http://lkml.kernel.org/r/20161021085848.1754-1-narmstrong at baylibre.com

Changes since v1 Pull Request at : http://lkml.kernel.org/r/1305c61f-b1ef-7caf-7788-67e2b907e873 at baylibre.com
 - Clarify copyright dates in commit message
 - Remove linux/arch/... lines from the top of the files

----------------------------------------------------------------
Neil Armstrong (2):
      ARM: oxnas: Add OX820 SMP support
      ARM: oxnas: Add OX820 config and makefile entry

 arch/arm/Makefile             |   1 +
 arch/arm/mach-oxnas/Kconfig   |  30 ++++++++----
 arch/arm/mach-oxnas/Makefile  |   2 +
 arch/arm/mach-oxnas/headsmp.S |  26 ++++++++++
 arch/arm/mach-oxnas/hotplug.c | 109 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-oxnas/platsmp.c | 102 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 261 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/mach-oxnas/Makefile
 create mode 100644 arch/arm/mach-oxnas/headsmp.S
 create mode 100644 arch/arm/mach-oxnas/hotplug.c
 create mode 100644 arch/arm/mach-oxnas/platsmp.c

Thanks,
Neil
