From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri,  7 Mar 2014 13:28:08 -0700
Subject: [GIT PULL 5/5] ARM: tegra: defconfig updates for 3.15
In-Reply-To: <1394224088-28910-1-git-send-email-swarren@wwwdotorg.org>
References: <1394224088-28910-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1394224088-28910-5-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following options are enabled:
- ams AS3722 is used as system PMIC for Tegra124 based Venice2.
- NXP PCA9546 is used in Cardhu Tegra30 board to connect to 3 cameras.
- GSPCA to support the webcam on Venice2.
- Allocate 64 MiB for CMA by default; the default 16MiB is not enough
  for the majority of use-cases. This can still be overridden by the cma
  command-line option.

----------------------------------------------------------------

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tegra-for-3.15-defconfig

for you to fetch changes up to d1c912c1001fb97c1233d0ce3379d0c3f25b8312:

  ARM: tegra: defconfig updates

----------------------------------------------------------------

Laxman Dewangan (1):
      ARM: tegra: defconfig updates

 arch/arm/configs/tegra_defconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
