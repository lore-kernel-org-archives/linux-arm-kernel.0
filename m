From: horms@verge.net.au (Simon Horman)
Date: Thu,  6 Sep 2012 11:02:07 +0900
Subject: [GIT PULL] Renesas ARM-based SoC: SoC for 3.7
Message-ID: <1346896928-5750-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following SoC enhancement from
Phil Edworthy for inclusion in 3.7.

----------------------------------------------------------------
The following changes since commit 7952717adb69efc1d2443a1858f96d23c2fb93e0:

  ARM: shmobile: kzm9g: enable restarting (2012-08-25 14:39:44 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git soc

for you to fetch changes up to 263510ec774b490dffbd0b8db7b723025cf560c9:

  r8a7779: add SDHI clock support (2012-09-06 10:49:18 +0900)

----------------------------------------------------------------
Phil Edworthy (1):
      r8a7779: add SDHI clock support

 arch/arm/mach-shmobile/clock-r8a7779.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)
