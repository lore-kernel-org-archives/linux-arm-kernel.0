From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 18 Sep 2014 11:51:32 -0600
Subject: [GIT PULL 3/3] ARM: tegra: tegra_defconfig changes for 3.18
In-Reply-To: <1411062692-22338-1-git-send-email-swarren@wwwdotorg.org>
References: <1411062692-22338-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1411062692-22338-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support is enabled for Venice2's touchpad, and Tegra124's AHCI (SATA)
controller, as used on Jetson TK1.

----------------------------------------------------------------

The following changes since commit 52addcf9d6669fa439387610bc65c92fa0980cef:

  Linux 3.17-rc2

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.18-defconfig

for you to fetch changes up to b82daf87a82fc2261f86f48d1bd0706da9e4a675:

  ARM: tegra: enable Atmel touchpad in defconfig

----------------------------------------------------------------

Mikko Perttunen (1):
      ARM: tegra: Add options for Tegra AHCI support to tegra_defconfig

Stephen Warren (1):
      ARM: tegra: enable Atmel touchpad in defconfig

 arch/arm/configs/tegra_defconfig | 4 ++++
 1 file changed, 4 insertions(+)
