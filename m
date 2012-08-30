From: horms@verge.net.au (Simon Horman)
Date: Thu, 30 Aug 2012 14:47:27 +0900
Subject: [GIT PULL] Renesas ARM-based SoC: KZM-A9-GT for 3.7 #2
Message-ID: <1346305648-25263-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following enhancement to the KZM-A9-GT board by
from Morimoto-san for inclusion in 3.7.

* This pull request is based on the devel branch of
  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
  which is based on v3.6-rc2.

  This is to satisfy compile-time dependencies.
  Please let me know if you would like this handled a different way.

* This and a previous pull request,
  "Renesas ARM-based SoC: KZM-9A-GT for 3.7", both touch board-kzm9g.c
  but I do not believe there is a conflict.

  Please let me know if you would like this handled a different way.

----------------------------------------------------------------
The following changes since commit f24a9172233cfc205ef7a999370412ab577783b1:

  gpio/mxs: adopt irq_domain support for mxs gpio driver (2012-08-23 23:49:17 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git kzm9g-gpio

for you to fetch changes up to af26b952cca1a87f31b09015fb3f7c77232036e1:

  ARM: shmobile: kzm9g: use gpio-keys instead of gpio-keys-polled (2012-08-30 13:59:31 +0900)

----------------------------------------------------------------
Kuninori Morimoto (1):
      ARM: shmobile: kzm9g: use gpio-keys instead of gpio-keys-polled

 arch/arm/configs/kzm9g_defconfig     | 2 +-
 arch/arm/mach-shmobile/board-kzm9g.c | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)
