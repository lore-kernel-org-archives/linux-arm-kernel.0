From: dinguyen@kernel.org (Dinh Nguyen)
Date: Mon, 16 Apr 2018 10:19:59 -0500
Subject: [GIT PULL] ARM: socfpga_defconfig: fix for v4.17
Message-ID: <1523891999-6068-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please pull in this fix for v4.17.

Thanks,
Dinh

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_defconfig_fix_v4.17

for you to fetch changes up to 6e8fe39989720b87439fee7817a5ca362b16d931:

  ARM: socfpga_defconfig: Remove QSPI Sector 4K size force (2018-04-16 09:14:30 -0500)

----------------------------------------------------------------
ARM: socfpga_defconfig: fix QSPI Sector 4k
- disable CONFIG_MTD_SPI_NOR_USE_4K_SECTORS

----------------------------------------------------------------
Thor Thayer (1):
      ARM: socfpga_defconfig: Remove QSPI Sector 4K size force

 arch/arm/configs/socfpga_defconfig | 1 +
 1 file changed, 1 insertion(+)
