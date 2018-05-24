From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Thu, 24 May 2018 15:59:44 +0800
Subject: [GIT PULL] berlin core changes for 4.18
Message-ID: <20180524155944.1de22147@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

Here is our mach-berlin changes for v4.18.

Thanks,
Jisheng

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jszhang/linux-berlin.git tags/berlin-core-for-v4.18

for you to fetch changes up to eb14767c8a9117fdd84fc79e6263c85a4d8ec934:

  ARM: berlin: switch to SPDX license identifier (2018-05-24 14:49:09 +0800)

----------------------------------------------------------------
berlin core changes for v4.18

BG2CD SoC uses r3p0 Cortex-A9 MPCore single-CPU cluster. Autoselect
pertinent errata, the SCU and the global timer, and allow use of the
local timer on uniprocessor kernels.

remove non-necessary flush_cache_all() after scu_enable().

switch to SPDX license identifier for all files under mach-berlin/

----------------------------------------------------------------
Alexander Monakov (1):
      ARM: berlin: extend BG2CD Kconfig entry

Jisheng Zhang (2):
      arm: berlin: remove non-necessary flush_cache_all()
      ARM: berlin: switch to SPDX license identifier

 arch/arm/mach-berlin/Kconfig   | 6 +++++-
 arch/arm/mach-berlin/berlin.c  | 5 +----
 arch/arm/mach-berlin/headsmp.S | 5 +----
 arch/arm/mach-berlin/platsmp.c | 6 +-----
 4 files changed, 8 insertions(+), 14 deletions(-)
