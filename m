From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Fri, 18 May 2012 23:44:59 +0200
Subject: [GIT PULL] Renesas sh73a0 fix for v3.5
Message-ID: <201205182344.59703.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please pull changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3

    Linux 3.4-rc6

with top-most commit 4da773193414788b52ae14bc246543390faca5ce

    ARM: mach-shmobile: sh73a0: fixup PINT/IRQ16-IRQ31 irq number conflict

from the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.git soc-core

to receive an sh73a0 fix related to the allocation of IRQs for v3.5.

This is based on material that has been merged into the arm-soc tree already.

Thanks!


 arch/arm/mach-shmobile/include/mach/sh73a0.h |   34 +++++++++++++++++++++++--
 1 files changed, 31 insertions(+), 3 deletions(-)

---------------

Kuninori Morimoto (1):
      ARM: mach-shmobile: sh73a0: fixup PINT/IRQ16-IRQ31 irq number conflict
