From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri,  4 Mar 2016 15:57:01 +0100
Subject: [GIT PULL 3/3] arm64: tegra: Devicetree changes for v4.6-rc1
In-Reply-To: <1457103421-26006-1-git-send-email-thierry.reding@gmail.com>
References: <1457103421-26006-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1457103421-26006-3-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.6-arm64

for you to fetch changes up to e81b390f02aea3d9c2745a5ff7b3a2eaad2317e7:

  arm64: tegra: Add gpio-keys nodes for Smaug (2016-03-04 08:49:09 +0100)

----------------------------------------------------------------
arm64: tegra: Devicetree changes for v4.6-rc1

The most interesting bit here is the addition of initial support for the
Google Pixel C (a.k.a. Smaug). It's far from feature complete but allows
booting to a login prompt from a root filesystem on the eMMC.

Other than that, this contains a selection of cleanups to various device
tree source files.

----------------------------------------------------------------
Jon Hunter (1):
      arm64: tegra: Add support for Google Pixel C

Laxman Dewangan (1):
      arm64: tegra: Enable power and volume keys on Jetson TX1

Rhyland Klein (1):
      arm64: tegra: Add gpio-keys nodes for Smaug

Sudeep Holla (1):
      arm64: tegra: Replace legacy *,wakeup property with wakeup-source

Thierry Reding (1):
      arm64: tegra: Fix copy/paste typo in several DTS includes

 arch/arm64/boot/dts/nvidia/Makefile            |   1 +
 arch/arm64/boot/dts/nvidia/tegra132-norrin.dts |   4 +-
 arch/arm64/boot/dts/nvidia/tegra132.dtsi       |   2 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi |  26 +++++
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts  | 126 +++++++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi       |   2 +-
 6 files changed, 157 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
