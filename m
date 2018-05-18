From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 18 May 2018 16:22:43 +0200
Subject: [GIT PULL 3/5] ARM: tegra: Core changes for v4.18-rc1
In-Reply-To: <20180518142245.20242-1-thierry.reding@gmail.com>
References: <20180518142245.20242-1-thierry.reding@gmail.com>
Message-ID: <20180518142245.20242-3-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.18-arm-soc

for you to fetch changes up to 15164e0072b579f77c9025f3da3ed931869b89cd:

  ARM: tegra: Create platform device for tegra20-cpufreq driver (2018-05-18 11:15:42 +0200)

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Core changes for v4.18-rc1

Contains a single patch that instantiates a platform device for the CPU
frequency driver.

----------------------------------------------------------------
Dmitry Osipenko (1):
      ARM: tegra: Create platform device for tegra20-cpufreq driver

 arch/arm/mach-tegra/tegra.c | 4 ++++
 1 file changed, 4 insertions(+)
