From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 18 Nov 2016 17:17:16 +0100
Subject: [GIT PULL 7/10] ARM: tegra: Device tree changes for v4.10-rc1
In-Reply-To: <20161118161719.24153-1-thierry.reding@gmail.com>
References: <20161118161719.24153-1-thierry.reding@gmail.com>
Message-ID: <20161118161719.24153-7-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.10-arm-dt

for you to fetch changes up to 5e8a724d143308f3195375951b0c8f01b2ca59fe:

  ARM: tegra: apalis-tk1: Drop leading 0 from unit-address (2016-11-08 11:14:02 +0100)

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Device tree changes for v4.10-rc1

Adds support for GMI on Tegra20 and Tegra30 and enables the GPU on Nyan
Chromebooks. It also enables sound support on various Toradex devices.

----------------------------------------------------------------
Marcel Ziswiler (1):
      ARM: tegra: apalis/colibri t30: Integrate audio

Mirza Krak (2):
      ARM: tegra: Add Tegra20 GMI support
      ARM: tegra: Add Tegra30 GMI support

Paul Kocialkowski (1):
      ARM: tegra: nyan: Enable GPU node and related supply

Thierry Reding (1):
      ARM: tegra: apalis-tk1: Drop leading 0 from unit-address

 arch/arm/boot/dts/tegra124-apalis.dtsi |  2 +-
 arch/arm/boot/dts/tegra124-nyan.dtsi   |  8 +++++-
 arch/arm/boot/dts/tegra20.dtsi         | 13 +++++++++
 arch/arm/boot/dts/tegra30-apalis.dtsi  | 49 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/tegra30-colibri.dtsi | 49 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/tegra30.dtsi         | 13 +++++++++
 6 files changed, 132 insertions(+), 2 deletions(-)
