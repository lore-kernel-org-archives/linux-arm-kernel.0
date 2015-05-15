From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 15 May 2015 12:54:05 +0200
Subject: [GIT PULL] ARM: berlin: SoC changes for v4.2 (round 1)
In-Reply-To: <1431687246-31039-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1431687246-31039-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1431687246-31039-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

this is Marvell Berlin SoC changes for v4.2 selecting MFD_SYSCON by
default for Berlin SoCs as now vital System/Chip controller drivers
depend on it.
	
Please pull.

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.infradead.org/users/hesselba/linux-berlin.git tags/berlin-soc-4.2-1

for you to fetch changes up to 64e4bb2b769352a0a7b1ca20a7f2b48add826f0f:

  ARM: berlin: select MFD_SYSCON by default (2015-04-27 21:40:35 +0200)

----------------------------------------------------------------
berlin/soc for v4.2:
- add MFD_SYSCON by default

----------------------------------------------------------------
Antoine Tenart (1):
      ARM: berlin: select MFD_SYSCON by default

 arch/arm/mach-berlin/Kconfig | 1 +
 1 file changed, 1 insertion(+)
