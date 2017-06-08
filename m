From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 8 Jun 2017 16:53:48 +0530
Subject: [GIT PULL 1/3] DaVinci SoC updates for v4.13
Message-ID: <20170608112350.1602-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.13/soc

for you to fetch changes up to 14ff86bc76be9b5c96f06ce141c8bdd612dafd64:

  ARM: davinci: da8xx: Add DSP internal RAM memories as IOMEM resources (2017-05-22 14:47:44 +0530)

----------------------------------------------------------------
DaVinci SoC support updates enhancing DSP remoteproc
support for DA850 SoC. This lays the foundation for
DT conversion of da8xx remoteproc driver.

----------------------------------------------------------------
Suman Anna (3):
      ARM: davinci: da8xx: Create DSP device only when assigned memory
      ARM: davinci: da8xx: Add names to DSP IOMEM resources
      ARM: davinci: da8xx: Add DSP internal RAM memories as IOMEM resources

 arch/arm/mach-davinci/devices-da8xx.c      | 30 ++++++++++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/da8xx.h |  5 +++++
 2 files changed, 35 insertions(+)
