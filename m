From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 23 Jan 2015 16:59:57 +0100
Subject: [GIT PULL 1/4] ARM: tegra: Device tree changes for v3.20
Message-ID: <1422028800-759-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-3.20-dt

for you to fetch changes up to 62981239a61bfd5306737effc015deba26c0d198:

  ARM: tegra: Update isl29028 compatible string to use isil vendor prefix (2015-01-09 13:42:04 +0100)

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Device tree changes for v3.20

A couple of unit addresses fixes in device trees, addition of microphone
detection on Chromebook 13 and a vendor prefix update.

----------------------------------------------------------------
Arnaud Ebalard (1):
      ARM: tegra: Update isl29028 compatible string to use isil vendor prefix

Dmitry Osipenko (1):
      ARM: dts: tegra20: fix GR3D, DSI unit and reg base addresses

Dylan Reid (1):
      ARM: tegra: Enable the mic-detect gpio on Acer Chromebook 13

Thierry Reding (1):
      ARM: tegra: Fix unit address for Cortex-A9 TWD timer

 arch/arm/boot/dts/tegra124-nyan-big.dts |  2 ++
 arch/arm/boot/dts/tegra20.dtsi          | 10 +++++-----
 arch/arm/boot/dts/tegra30-cardhu.dtsi   |  2 +-
 arch/arm/boot/dts/tegra30.dtsi          |  2 +-
 4 files changed, 9 insertions(+), 7 deletions(-)
