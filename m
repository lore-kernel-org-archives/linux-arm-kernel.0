From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 28 May 2013 14:36:17 -0400
Subject: [GIT PULL] ARM: mvebu: soc changes for v3.11 (round 2 cumulative)
Message-ID: <20130528183617.GB31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

summary is cumulative.


The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/soc-3.11-2

for you to fetch changes up to efde309297a08e32d89e4a96c4051e86dcd50b45:

  arm: kirkwood: Instantiate cpufreq driver (2013-05-26 17:56:24 +0000)

----------------------------------------------------------------
mvebu soc changes for v3.11 (round 2)

 - kirkwood
    - use the cpufreq driver

----------------------------------------------------------------
Andrew Lunn (1):
      arm: kirkwood: Instantiate cpufreq driver

Thomas Petazzoni (1):
      arm: kirkwood: use the default of match table

 arch/arm/Kconfig                                  |  1 +
 arch/arm/mach-kirkwood/board-dt.c                 |  9 +++------
 arch/arm/mach-kirkwood/common.c                   | 23 +++++++++++++++++++++++
 arch/arm/mach-kirkwood/common.h                   |  2 ++
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h |  2 ++
 5 files changed, 31 insertions(+), 6 deletions(-)
