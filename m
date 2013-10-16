From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 16 Oct 2013 08:52:51 +0530
Subject: [GIT PULL] DaVinci: an SoC update for v3.13
Message-ID: <525E068B.4020304@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 61e6cfa80de5760bbe406f4e815b7739205754d2:

  Linux 3.12-rc5 (2013-10-13 15:41:28 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.13/soc-2

for you to fetch changes up to 859236d017978bb95f3e2794aece57da3a40fe5c:

  ARM: davinci: convert to clockevents_config_and_register (2013-10-16 06:14:55 +0530)

----------------------------------------------------------------
This pull request includes a patch to
use clockevents_config_and_register()
for registering the clockevent.

----------------------------------------------------------------
Uwe Kleine-K?nig (1):
      ARM: davinci: convert to clockevents_config_and_register

 arch/arm/mach-davinci/time.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)
