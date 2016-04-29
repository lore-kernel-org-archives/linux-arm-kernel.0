From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Apr 2016 18:21:08 +0200
Subject: [GIT PULL] arm64: tegra: Enable GM20B GPU on Tegra210
Message-ID: <1461946869-26124-3-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC maintainers,

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.7-gm20b

for you to fetch changes up to 30f949bc6682d4912dbc74e7e757c66b3e3a6469:

  arm64: tegra: Add IOMMU node to GM20B on Tegra210 (2016-04-26 18:41:43 +0200)

Thanks,
Thierry

----------------------------------------------------------------
arm64: tegra: Enable GM20B GPU on Tegra210

Complement the GM20B GPU device tree node on Tegra210 with missing
properties to make it usable.

----------------------------------------------------------------
Alexandre Courbot (5):
      dt-bindings: gk20a: Fix typo in compatible name
      dt-bindings: gk20a: Document iommus property
      dt-bindings: Add documentation for GM20B GPU
      arm64: tegra: Add reference clock to GM20B on Tegra210
      arm64: tegra: Add IOMMU node to GM20B on Tegra210

 .../devicetree/bindings/gpu/nvidia,gk20a.txt       | 37 +++++++++++++++++++---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  8 +++--
 2 files changed, 38 insertions(+), 7 deletions(-)
