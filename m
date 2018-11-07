From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed,  7 Nov 2018 10:06:26 -0600
Subject: [GIT PULL] ARM: dts: stratix10 fix for v4.20
Message-ID: <20181107160626.11892-1-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please pull in this ethernet dts entry for Stratix10.

Thanks,
Dinh


The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/stratix10_dts_fix_for_v4.20

for you to fetch changes up to fd5ba6ee3187617287fb9cb187e3d6b3631210a3:

  arm64: dts: stratix10: fix multicast filtering (2018-11-05 13:17:33 -0600)

----------------------------------------------------------------
ARM: dts: stratix10: fix multicast filtering

----------------------------------------------------------------
Aaro Koskinen (1):
      arm64: dts: stratix10: fix multicast filtering

 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 3 +++
 1 file changed, 3 insertions(+)
