From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 28 Jan 2015 01:15:07 +0100
Subject: [GIT PULL] ARM: rockchip: second batch of dts updates for 3.20
Message-ID: <2511110.jH7fOBdjlK@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

here are some more devicetree changes for Rockchip boards.
The tag messages explains the contents hopefully enough.

And even the subject is correct this time ;-)

So please pull


Thanks
Heiko


The following changes since commit 5963e106df7b601a8f23cbbaac1420e4c740ada6:

  ARM: dts: rockchip: add suspend settings for rk3288-evb-rk808 (2014-12-31 16:19:18 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.20-rockchip-dts2

for you to fetch changes up to 11ff8c86d74002cb493407742fd1c128055e1abe:

  ARM: dts: rockchip: add dts for ChipSPARK Rayeager PX2 board (2015-01-26 02:15:36 +0100)

----------------------------------------------------------------
Basic display nodes for lcdcs and hdmi encoder, timer node
for the broadcast timer going through the clocksource tree
and two new boards, the rk3288-based Firefly and the
PX2-based Rayeager board (the PX2 is identical to the rk3066
but made for industrial users).

----------------------------------------------------------------
Andy Yan (1):
      ARM: dts: rockchip: add rk3288 hdmi nodes

Daniel Kurtz (1):
      ARM: dts: rockchip: Add rk3288 vop and display-subsystem

Daniel Lezcano (1):
      ARM: dts: rockchip: Add rockchip timer node for rk3288

FUKAUMI Naoki (3):
      dt-bindings: add vendor prefix and root compatible property for Rockchip boards
      ARM: dts: rockchip: add dts for Firefly Firefly-RK3288 boards
      ARM: dts: rockchip: add dts for ChipSPARK Rayeager PX2 board

 Documentation/devicetree/bindings/arm/rockchip.txt |  10 +
 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 arch/arm/boot/dts/Makefile                         |   5 +-
 arch/arm/boot/dts/rk3066a-rayeager.dts             | 468 +++++++++++++++++++++
 arch/arm/boot/dts/rk3288-firefly-beta.dts          |  71 ++++
 arch/arm/boot/dts/rk3288-firefly.dts               |  71 ++++
 arch/arm/boot/dts/rk3288-firefly.dtsi              | 467 ++++++++++++++++++++
 arch/arm/boot/dts/rk3288.dtsi                      |  84 ++++
 8 files changed, 1177 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/rk3066a-rayeager.dts
 create mode 100644 arch/arm/boot/dts/rk3288-firefly-beta.dts
 create mode 100644 arch/arm/boot/dts/rk3288-firefly.dts
 create mode 100644 arch/arm/boot/dts/rk3288-firefly.dtsi
