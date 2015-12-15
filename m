From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 15 Dec 2015 17:06:24 +0530
Subject: [GIT PULL] DaVinci fixes for v4.5
Message-ID: <566FFB38.50801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here are couple of fixes I collected for v4.5

Thanks,
Sekhar

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.5/fixes

for you to fetch changes up to 5bcd927233d18fbfabed461b31b0118147648525:

  ARM: davinci: fix a problematic usage of WARN() (2015-12-15 15:29:34 +0530)

----------------------------------------------------------------
This pull request includes a fix for
improper usage of WARN() and a fix
for unmet 'select' dependencies.

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: davinci: only select WT cache if cache is enabled

Geliang Tang (1):
      ARM: davinci: fix a problematic usage of WARN()

 arch/arm/mach-davinci/Kconfig               | 3 ++-
 arch/arm/mach-davinci/board-dm355-evm.c     | 4 +---
 arch/arm/mach-davinci/board-dm355-leopard.c | 4 +---
 3 files changed, 4 insertions(+), 7 deletions(-)
