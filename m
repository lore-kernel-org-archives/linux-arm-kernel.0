From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 3 Jan 2011 23:48:24 +0800
Subject: [GIT PULL] pxa: 3 fixes for 2.6.37-rc8
Message-ID: <AANLkTi=Xmv+jbhtu6+PPAuB9CETV74WsYe3oB1fj0D3Z@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 387c31c7e5c9805b0aef8833d1731a5fe7bdea14:

  Linux 2.6.37-rc8 (2010-12-28 17:05:48 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git fix

Aric D. Blumer (1):
      ARM: pxa: fix page table corruption on resume

Lennert Buytenhek (1):
      ARM: pxa: PXA_ESERIES depends on FB_W100.

Mike Rapoport (1):
      ARM: it8152: add IT8152_LAST_IRQ definition to fix build error

 arch/arm/include/asm/hardware/it8152.h |    1 +
 arch/arm/mach-pxa/Kconfig              |    1 +
 arch/arm/mach-pxa/sleep.S              |    4 ++--
 3 files changed, 4 insertions(+), 2 deletions(-)
