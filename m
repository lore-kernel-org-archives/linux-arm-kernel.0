From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 31 Dec 2014 11:53:08 +0100
Subject: [GIT PULL] ARM: rockchip: dts fix for 3.19
Message-ID: <2451485.a1EjNQjEOm@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

as the tag explains, a small fix increasing the drive-strength of sdmmc pins
to fix card communication issues introduced by a dw_mmc fix.


Thanks and happy new year
Heiko


The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.19-rockchip-dtsfixes1

for you to fetch changes up to 6618e478954d2866754798c3b07805dc9dbb2fc4:

  ARM: dts: rockchip: bump sd card pin drive strength up on rk3288-evb (2014-12-21 15:02:10 +0100)

----------------------------------------------------------------
Increase drive-strength to sdmmc pins on rk3288-evb to fix
an issue with the fixed highspeed card detection.

----------------------------------------------------------------
Doug Anderson (1):
      ARM: dts: rockchip: bump sd card pin drive strength up on rk3288-evb

 arch/arm/boot/dts/rk3288-evb.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
