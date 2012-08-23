From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Fri, 24 Aug 2012 01:18:16 +0200
Subject: [GIT PULL] Renesas ARM-based SoC fix for v3.6
Message-ID: <201208240118.16563.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please pull from the git repository at

  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.git fixes

to receive one fix for the sh73a0 SoC support code as commit
6c0274cbe63ec265f842537825684a619e6cce93

  ARM: shmobile: sh73a0: fixup RELOC_BASE of intca_irq_pins_desc

on top of commit d9875690d9b89a866022ff49e3fcea892345ad92

  Linux 3.6-rc2

It fixes an IRQ configuration issue uncovered by the addition of
preliminary irqdomain support.

Thanks!


 arch/arm/mach-shmobile/intc-sh73a0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

---------------

Kuninori Morimoto (1):
      ARM: shmobile: sh73a0: fixup RELOC_BASE of intca_irq_pins_desc
