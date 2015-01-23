From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 23 Jan 2015 16:59:58 +0100
Subject: [GIT PULL 2/4] ARM: tegra: Default configuration changes for v3.20
In-Reply-To: <1422028800-759-1-git-send-email-thierry.reding@gmail.com>
References: <1422028800-759-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1422028800-759-2-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-3.20-defconfig

for you to fetch changes up to fe07e48964c6f21020eeeb7f83e35a5bf1977a65:

  ARM: tegra: Regenerate defconfig based on v3.19-rc1 (2015-01-06 14:10:57 +0100)

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Default configuration changes for v3.20

This is merely a regeneration of the default configuration to get rid of
two symbols that are now enabled by default or removed.

----------------------------------------------------------------
Thierry Reding (1):
      ARM: tegra: Regenerate defconfig based on v3.19-rc1

 arch/arm/configs/tegra_defconfig | 2 --
 1 file changed, 2 deletions(-)
