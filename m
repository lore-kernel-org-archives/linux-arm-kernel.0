From: tony@atomide.com (Tony Lindgren)
Date: Wed,  7 Jun 2017 05:23:01 -0700
Subject: [GIT PULL] two omap fixes for v4.12-rc cycle
Message-ID: <pull-1496838127-161331>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit bca5238816939436d72ae6bab124c4b0641a3a99:

  ARM: dts: dra7: Reduce cpu thermal shutdown temperature (2017-05-17 06:51:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.12/fixes-sl50

for you to fetch changes up to db145db99f5bf30acc12d7450b9ad0707072a7be:

  ARM: dts: am335x-sl50: Fix cannot claim requested pins for spi0 (2017-05-26 08:25:42 -0700)

----------------------------------------------------------------
Two fixes for am335x-sl50 to fix a boot time error
for claiming SPI pins, and to fix a SDIO card detect
pin for production version of the device.

----------------------------------------------------------------
Enric Balletbo i Serra (2):
      ARM: dts: am335x-sl50: Fix card detect pin for mmc1
      ARM: dts: am335x-sl50: Fix cannot claim requested pins for spi0

 arch/arm/boot/dts/am335x-sl50.dts | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)
