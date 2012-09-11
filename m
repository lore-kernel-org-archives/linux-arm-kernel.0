From: horms@verge.net.au (Simon Horman)
Date: Tue, 11 Sep 2012 14:26:04 +0900
Subject: [GIT PULL] GPIO: KZM-A9-GT for 3.7
Message-ID: <1347341165-15573-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

please consider the following GPIO enhancement for the kzm9g board
for 3.7. As discussed previously it depends on changes in devel tree
and thus seems to be appropriate to merge there.

----------------------------------------------------------------
The following changes since commit a3b930815d07e2a8a25e85496839f80facb3654d:

  gpio: sx150x: Use irq_data_get_irq_chip_data() at appropriate places (2012-09-06 09:19:04 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git gpio

for you to fetch changes up to b7a3ce41bb1ca65954029fb002373524bafb3161:

  ARM: shmobile: kzm9g: use gpio-keys instead of gpio-keys-polled (2012-09-11 13:54:57 +0900)

----------------------------------------------------------------
Kuninori Morimoto (1):
      ARM: shmobile: kzm9g: use gpio-keys instead of gpio-keys-polled

 arch/arm/configs/kzm9g_defconfig     |    2 +-
 arch/arm/mach-shmobile/board-kzm9g.c |    5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)
