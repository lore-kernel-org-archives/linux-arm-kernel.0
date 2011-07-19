From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Jul 2011 16:06:26 +0200
Subject: [GIT PULL] arm-soc: last minute arm/davinci fixes for 3.0
Message-ID: <201107191606.26837.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

I got some last bug fixes for 3.0. Please pull if you still take 3.0 related
changes, otherwise I'll mark them for stable backports and put them into
the first arm-soc batch for the 3.1 merge window.

	Arnd

The following changes since commit 620917de59eeb934b9f8cf35cc2d95c1ac8ed0fc:

  Linux 3.0-rc7 (2011-07-11 16:51:52 -0700)

are available in the git repository at:
  git+ssh://master.kernel.org/pub/scm/linux/kernel/git/arm/linux-arm-soc.git fixes

Ido Yariv (1):
      arm: davinci: Fix low level gpio irq handlers' argument

Jon Povey (1):
      davinci: DM365 EVM: fix video input mux bits

Todd Poynor (1):
      ARM: davinci: Check for NULL return from irq_alloc_generic_chip

 arch/arm/mach-davinci/board-dm365-evm.c |    4 ++--
 arch/arm/mach-davinci/gpio.c            |   21 ++++++++++++++++-----
 arch/arm/mach-davinci/irq.c             |    6 ++++++
 3 files changed, 24 insertions(+), 7 deletions(-)
