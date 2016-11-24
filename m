From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 24 Nov 2016 16:41:48 +0100
Subject: [GIT PULL 1/3] Rockchip defconfig64 changes for 4.10
Message-ID: <1594090.z775ZFR2cz@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

please find below (and in the replies) some more pull requests
for 4.10.

If that is to late, feel free to ignore them and I'll resubmit
after 4.10-rc.


Thanks
Heiko

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.10-rockchip-defconfig64

for you to fetch changes up to 92d22d77b14c988bce0293502a1b3ef25b267ed9:

  arm64: defconfig: allow rk3399-based boards to boot from mmc and usb (2016-11-17 17:15:59 +0100)

----------------------------------------------------------------
64bit defconfig changes to allow arm64 Rockchip socs
to basically boot.

----------------------------------------------------------------
Andy Yan (2):
      arm64: defconfig: enable I2C and DW MMC controller on rockchip platform
      arm64: defconfig: enable RK808 components

Heiko Stuebner (1):
      arm64: defconfig: allow rk3399-based boards to boot from mmc and usb

 arch/arm64/configs/defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)
