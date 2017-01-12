From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Jan 2017 14:01:47 +0100
Subject: [GIT PULL] Ux500 PM fix from Arnd
Message-ID: <CACRpkdbb5JkPW=1ObA8eAnyKJ5vmEWkHa4Wmv-qRQa2Vr2xjLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

this was forgotten on my fixes branch, sorry. Please pull it
in for fixes in the ARM SoC tree.

Yours,
Linus Walleij


The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-fix-for-armsoc

for you to fetch changes up to f0e8faa7a5e894b0fc99d24be1b18685a92ea466:

  ARM: ux500: fix prcmu_is_cpu_in_wfi() calculation (2017-01-12 13:25:39 +0100)

----------------------------------------------------------------
A single PM fix from Arnd

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: ux500: fix prcmu_is_cpu_in_wfi() calculation

 arch/arm/mach-ux500/pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
