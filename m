From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 13 May 2015 15:49:40 +0200
Subject: [GIT PULL 8/8] ARM: tegra: Default configuration updates for v4.2-rc1
In-Reply-To: <1431524980-13599-1-git-send-email-thierry.reding@gmail.com>
References: <1431524980-13599-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1431524980-13599-9-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.2-defconfig

for you to fetch changes up to 5f9c2187d6cfac15b44b584c403e187321a4c062:

  ARM: tegra: Update default configuration (2015-05-05 14:20:16 +0200)

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Default configuration updates for v4.2-rc1

This is a set of changes to the Tegra default configuration that enable
various new features (HDMI audio, watchdog) on Toradex Apalis T30.

----------------------------------------------------------------
Thierry Reding (1):
      ARM: tegra: Update default configuration

 arch/arm/configs/tegra_defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)
