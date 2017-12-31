From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun, 31 Dec 2017 16:34:42 +0100
Subject: [GIT PULL] ARM: at91: drivers for 4.16
Message-ID: <20171231153442.GA22004@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

A single harmless change for this pull request. I hope you'll enjoy this
New Year's Eve.

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.16-drivers

for you to fetch changes up to 1203839290f151b84f5e54165d6d039e9514b236:

  pcmcia: at91_cf: Use PTR_ERR_OR_ZERO() (2017-11-29 21:58:58 +0100)

----------------------------------------------------------------
drivers for 4.16

 - use PTR_ERR_OR_ZERO were relevant in at91_cf

----------------------------------------------------------------
Vasyl Gomonovych (1):
      pcmcia: at91_cf: Use PTR_ERR_OR_ZERO()

 drivers/pcmcia/at91_cf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
