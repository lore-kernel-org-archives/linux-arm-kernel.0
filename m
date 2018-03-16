From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 16 Mar 2018 15:18:49 +0100
Subject: [GIT PULL 6/7] arm64: Default configuration updates for v4.17-rc1
In-Reply-To: <20180316141850.4876-1-thierry.reding@gmail.com>
References: <20180316141850.4876-1-thierry.reding@gmail.com>
Message-ID: <20180316141850.4876-6-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.17-arm64-defconfig

for you to fetch changes up to dc7073b0234ee6f48a8e609cd2def777de1e2d26:

  arm64: defconfig: Enable the Tegra SMMU by default (2018-03-14 13:27:41 +0100)

Thanks,
Thierry

----------------------------------------------------------------
arm64: Default configuration updates for v4.17-rc1

Enable the BPMP thermal and CPU frequency drivers as well as make sure
that the Tegra SMMU is enabled by default because there's no fun without
it. Also enable initial Tegra194 support.

----------------------------------------------------------------
Mikko Perttunen (3):
      arm64: defconfig: Enable NVIDIA Tegra194 support
      arm64: defconfig: Enable CONFIG_ARM_TEGRA186_CPUFREQ
      arm64: defconfig: Enable CONFIG_TEGRA_BPMP_THERMAL

Thierry Reding (1):
      arm64: defconfig: Enable the Tegra SMMU by default

 arch/arm64/configs/defconfig | 6 ++++++
 1 file changed, 6 insertions(+)
