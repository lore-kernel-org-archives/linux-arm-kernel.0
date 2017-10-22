From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun, 22 Oct 2017 21:53:16 +0200
Subject: [GIT PULL] ARM: at91: soc for 4.15
Message-ID: <20171022195316.xzcge6fynmdogcft@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

The addition of a few SoC ids and a change to the maintainers entry to
also match the various at91 related drivers.

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.15-soc

for you to fetch changes up to faec5ee1c7acb00eec4853321e4da42cd690a220:

  MAINTAINERS: Add SoC drivers to AT91 entry (2017-09-17 19:45:59 +0200)

----------------------------------------------------------------
soc for 4.15

 - add SoC ids for the sama5d2 SiPs
 - Improve the AT91 maintainers entry

----------------------------------------------------------------
Alexandre Belloni (1):
      MAINTAINERS: Add SoC drivers to AT91 entry

Cristian Birsan (1):
      drivers: soc: atmel: Add basic support for new sama5d2 SiPs

 MAINTAINERS             | 5 +++++
 drivers/soc/atmel/soc.c | 8 ++++++++
 drivers/soc/atmel/soc.h | 4 ++++
 3 files changed, 17 insertions(+)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
