From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 20 Oct 2015 15:17:38 +0200
Subject: [GIT PULL 4/4] ARM: tegra: Default configuration updates for v4.4-rc1
In-Reply-To: <1445347058-8834-1-git-send-email-thierry.reding@gmail.com>
References: <1445347058-8834-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1445347058-8834-4-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.4-defconfig

for you to fetch changes up to 2fb43cecf5164fd99d0fd9fdd87f40e5148ecd91:

  ARM: tegra: Update multi_v7_defconfig (2015-10-20 14:47:07 +0200)

----------------------------------------------------------------
ARM: tegra: Default configuration updates for v4.4-rc1

Enable touchscreen and audio support on Toradex Colibri platforms.

----------------------------------------------------------------
Marcel Ziswiler (1):
      ARM: tegra: Update default configuration

Thierry Reding (2):
      ARM: tegra: Rebuild default configuration on v4.3-rc1
      ARM: tegra: Update multi_v7_defconfig

 arch/arm/configs/multi_v7_defconfig |  2 ++
 arch/arm/configs/tegra_defconfig    | 10 +++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)
