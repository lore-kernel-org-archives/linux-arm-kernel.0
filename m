From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 18 Jul 2014 16:45:40 +0200
Subject: [GIT PULL 7/7] ARM: tegra: defconfig updates for 3.17
In-Reply-To: <1405694740-4090-1-git-send-email-thierry.reding@gmail.com>
References: <1405694740-4090-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1405694740-4090-7-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-3.17-defconfig

for you to fetch changes up to dff15d4c2b1a4f3992a670b445e2131a400aef76:

  ARM: tegra: enable igb, stmpe, i2c chardev, lm95245, pwm leds (2014-06-16 12:55:49 -0600)

----------------------------------------------------------------
ARM: tegra: defconfig updates for 3.17

This set of patches update the tegra_defconfig by first regenerating on
top of v3.16-rc1 to prune all non-existent symbols or symbols which are
now selected by default.

----------------------------------------------------------------
Marcel Ziswiler (1):
      ARM: tegra: enable igb, stmpe, i2c chardev, lm95245, pwm leds

Stephen Warren (1):
      ARM: tegra: rebuild tegra_defconfig

 arch/arm/configs/tegra_defconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)
