From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 20 Dec 2017 20:18:59 +0100
Subject: [GIT PULL 4/5] ARM: tegra: Device tree changes for v4.16-rc1
In-Reply-To: <20171220191900.757-1-thierry.reding@gmail.com>
References: <20171220191900.757-1-thierry.reding@gmail.com>
Message-ID: <20171220191900.757-4-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.16-arm-dt

for you to fetch changes up to bb768f28b29e7c72875d8521e2d5b09337561365:

  ARM: tegra: Add video decoder on Tegra20 (2017-12-20 19:57:20 +0100)

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Device tree changes for v4.16-rc1

These changes enable the video decoder engine found on Tegra20 SoCs.

----------------------------------------------------------------
Dmitry Osipenko (1):
      ARM: tegra: Add video decoder on Tegra20

Vladimir Zapolskiy (1):
      ARM: tegra: Add device tree node to describe IRAM on Tegra20

 arch/arm/boot/dts/tegra20.dtsi | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
