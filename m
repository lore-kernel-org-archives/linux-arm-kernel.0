From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri,  7 Apr 2017 01:10:17 +0200
Subject: [GIT PULL 1/4] dt-bindings: Updates for v4.12-rc1
Message-ID: <20170406231020.32048-1-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.12-dt-bindings

for you to fetch changes up to bf594a896cdbae4a581eb80a2bdbda8df6997d75:

  dt-bindings: Add documentation for GP10B GPU (2017-04-04 16:08:18 +0200)

Thanks,
Thierry

----------------------------------------------------------------
dt-bindings: Updates for v4.12-rc1

This contains an update for the flow controller device tree binding as
well as the addition of the binding for the GP10B GPU found on the new
Tegra186 (Parker) SoC.

----------------------------------------------------------------
Alexandre Courbot (1):
      dt-bindings: Add documentation for GP10B GPU

Jon Hunter (1):
      dt-bindings: tegra: Update compatible strings for Tegra flowctrl

 .../bindings/arm/tegra/nvidia,tegra20-flowctrl.txt |  8 ++++++-
 .../devicetree/bindings/gpu/nvidia,gk20a.txt       | 25 +++++++++++++++++++++-
 2 files changed, 31 insertions(+), 2 deletions(-)
