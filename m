From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 16 Mar 2018 15:18:45 +0100
Subject: [GIT PULL 2/7] dt-bindings: Changes for v4.17-rc1
In-Reply-To: <20180316141850.4876-1-thierry.reding@gmail.com>
References: <20180316141850.4876-1-thierry.reding@gmail.com>
Message-ID: <20180316141850.4876-2-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.17-dt-bindings

for you to fetch changes up to 2c7305569296719094c9f67481249e2e61dbee6a:

  dt/bindings: Fix binding examples for Tegra GMI controller (2018-03-08 16:03:33 +0100)

Thanks,
Thierry

----------------------------------------------------------------
dt-bindings: Changes for v4.17-rc1

Mostly cleanup of existing bindings and initial support for Tegra194.

----------------------------------------------------------------
Marcel Ziswiler (2):
      dt-bindings: phy: Clarify ULPI PHY source clock
      dt/bindings: Fix binding examples for Tegra GMI controller

Mikko Perttunen (2):
      dt-bindings: tegra: Add missing chips and NVIDIA boards
      dt-bindings: tegra: Add documentation for nvidia,tegra194-pmc

 Documentation/devicetree/bindings/arm/tegra.txt          | 16 ++++++++++++++++
 .../bindings/arm/tegra/nvidia,tegra186-pmc.txt           |  2 ++
 .../devicetree/bindings/bus/nvidia,tegra20-gmi.txt       |  6 ++----
 .../devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt   |  4 +++-
 4 files changed, 23 insertions(+), 5 deletions(-)
