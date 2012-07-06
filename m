From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri,  6 Jul 2012 10:46:43 -0600
Subject: [GIT PULL 2/7] ARM: tegra: for-3.6/fixes branch
In-Reply-To: <1341593208-17914-1-git-send-email-swarren@wwwdotorg.org>
References: <1341593208-17914-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1341593208-17914-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch contains various small bug-fixes to Tegra code.

This branch is based on Tegra's for-3.6/cleanup branch from the previous pull
request.

This branch is included in a later pull request.

----------------------------------------------------------------

The following changes since commit 702b0e4f2f2782962aab7d9a0a40ad68770bb1f6:

  ARM: dt: tegra: rename board files to match SoC

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git for-3.6/fixes

for you to fetch changes up to 8994c34c194d5f59f014d3c3b90eb677672ddb03:

  ARM: tegra: apbio access using dma for tegra20 only

----------------------------------------------------------------

Laxman Dewangan (1):
      ARM: tegra: apbio access using dma for tegra20 only

Roland Stigge (1):
      ARM: tegra: Fix dts files w/ status property: "disable" -> "disabled"

Wolfram Sang (1):
      ARM: tegra: build powergate unconditionally

 arch/arm/boot/dts/tegra20.dtsi |   36 ++++++++++----------
 arch/arm/boot/dts/tegra30.dtsi |   38 +++++++++++-----------
 arch/arm/mach-tegra/Makefile   |    5 ++-
 arch/arm/mach-tegra/apbio.c    |   59 ++++++++++++++++++++++++++++++++---
 arch/arm/mach-tegra/apbio.h    |   19 +----------
 arch/arm/mach-tegra/common.c   |    3 ++
 6 files changed, 98 insertions(+), 62 deletions(-)
