From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri,  4 May 2018 17:38:25 +0200
Subject: [GIT PULL] ARM: tegra: Device tree fixes for v4.17
Message-ID: <20180504153825.1074-1-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.17-fixes

for you to fetch changes up to 9bf4e370048d2bbae5262d0c6280e0142804a272:

  ARM: dts: tegra20: Revert "Fix ULPI regression on Tegra20" (2018-05-04 17:32:29 +0200)

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Device tree fixes for v4.17

This contains a single revert for a patch that was merged in v4.17-rc1
and that turns out to cause a regression on some boards. Further, the
original issue that the patch was supposed to fix seems to have
disappeared.

----------------------------------------------------------------
Dmitry Osipenko (1):
      ARM: dts: tegra20: Revert "Fix ULPI regression on Tegra20"

 arch/arm/boot/dts/tegra20.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
