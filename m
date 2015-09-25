From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 25 Sep 2015 17:25:12 +0200
Subject: [GIT PULL] pxa fixes for v4.3
Message-ID: <87bncqo71j.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd, Kevin, Olof,

Please consider this pull request for pxa fixes for 4.3, made of 3 small
regression fixes.

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-fixes-v4.3

for you to fetch changes up to 385877c01361401113c101ef5a80a9f0998e072b:

  ARM: pxa: balloon3: Fix build error (2015-09-16 21:24:58 +0200)

----------------------------------------------------------------
ARM: pxa: fixes for v4.3

These fixes are mainly regression fixes triggered by irq changes,
common clock framework introduction and sound side-effect of
other platforms.

----------------------------------------------------------------
Axel Lin (1):
      ARM: pxa: balloon3: Fix build error

Jarkko Nikula (1):
      ARM: pxa: ssp: Fix build error by removing originally incorrect DT binding

Robert Jarzmik (1):
      ARM: pxa: fix DFI bus lockups on startup

 arch/arm/mach-pxa/balloon3.c              |  2 +-
 arch/arm/mach-pxa/include/mach/addr-map.h |  7 +++++++
 arch/arm/mach-pxa/pxa3xx.c                | 21 ++++++++++++++++++++-
 arch/arm/plat-pxa/ssp.c                   |  1 -
 4 files changed, 28 insertions(+), 3 deletions(-)

Cheers.

-- 
Robert
