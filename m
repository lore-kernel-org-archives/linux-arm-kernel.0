From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 12 Jul 2018 17:41:28 +0200
Subject: [GIT PULL 5/5] arm64: tegra: Device tree changes for v4.19-rc1
In-Reply-To: <20180712154128.22705-1-thierry.reding@gmail.com>
References: <20180712154128.22705-1-thierry.reding@gmail.com>
Message-ID: <20180712154128.22705-6-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.19-arm64-dt

for you to fetch changes up to 7780a03495e13cd2bef704bcbf8c727de9f65232:

  arm64: tegra: Add CPU nodes to Tegra194 device tree (2018-07-02 15:57:39 +0200)

Thanks,
Thierry

----------------------------------------------------------------
arm64: tegra: Device tree changes for v4.19-rc1

These changes enable the GPIO controllers on Tegra194 SoCs, which in
turn allows the SD card detection and ethernet controllers to be enabled
as well. The Tegra194 device tree is also extended with the list of CPUs
and a PSCI node to inform the kernel about the presence of PSCI capable
firmware.

----------------------------------------------------------------
Mikko Perttunen (4):
      arm64: tegra: Add GPIO controller on Tegra194
      arm64: tegra: Enable card detect for SD card on P2888
      arm64: tegra: Add ethernet controller on Tegra194
      arm64: tegra: Add CPU nodes to Tegra194 device tree

 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi |  22 ++++-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi       | 106 +++++++++++++++++++++++++
 2 files changed, 126 insertions(+), 2 deletions(-)
