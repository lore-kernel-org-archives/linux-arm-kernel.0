From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 15 Oct 2015 21:22:59 +0200
Subject: [GIT PULL] ARM: berlin: SoC changes for v4.4 (round 2)
Message-ID: <1444936979-15901-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Kevin, Olof,

this is the second PR for Marvell Berlin SoC changes for v4.4. Jisheng
added cpu hotplug support by using a non-self-clearing version of the
reset register.

Please pull.

Sebastian

The following changes since commit e1a3e724a25761a2b2e9e0e059e33afac6409a76:

  ARM: berlin: register cpufreq-dt (2015-09-21 22:57:24 +0200)

are available in the git repository at:

  git://git.infradead.org/users/hesselba/linux-berlin.git tags/berlin-soc-for-4.4-2

for you to fetch changes up to a7b3d5a715f489ee542e59d722281c9f16da50dc:

  arm: berlin: add CPU hotplug support (2015-10-15 21:14:28 +0200)

----------------------------------------------------------------
Marvell Berlin SoC for 4.4 take 2
- use the non-self-clearing reset register
- add cpu hotplug support

----------------------------------------------------------------
Jisheng Zhang (2):
      arm: berlin: use non-self-cleared reset register to reset cpu
      arm: berlin: add CPU hotplug support

 arch/arm/mach-berlin/platsmp.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)
