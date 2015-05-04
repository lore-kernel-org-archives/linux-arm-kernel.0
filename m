From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  4 May 2015 13:57:42 +0200
Subject: [GIT PULL] ARM: tegra: Device tree fixes for v4.1-rc3
Message-ID: <1430740662-30151-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.1-fixes-for-rc3

for you to fetch changes up to a4b6916cb3578b05f30ef520cd6deb7f8fd97dda:

  ARM: tegra: Correct which USB controller has the UTMI pad registers (2015-04-28 16:47:38 +0200)

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Device tree fixes for v4.1-rc3

This contains a fix for a bug that was introduced a couple of months ago
by a patch that git misapplied because of a lack of context.

----------------------------------------------------------------
Tomeu Vizoso (1):
      ARM: tegra: Correct which USB controller has the UTMI pad registers

 arch/arm/boot/dts/tegra124.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
