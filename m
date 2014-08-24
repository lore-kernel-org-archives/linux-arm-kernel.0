From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 24 Aug 2014 19:19:04 +0200
Subject: [GIT PULL] ARM: rockchip: fix for 3.17
Message-ID: <22727156.KdIJnQG6cX@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

one fix and one list addition hopefully for 3.17-rc.
So if applicable please pull


The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.17-rockchip-fixes1

for you to fetch changes up to 00250b529313d6262bb0ebbd6bdf0a88c809f6f0:

  MAINTAINERS: add new Rockchip SoC list (2014-08-23 13:22:05 +0200)

----------------------------------------------------------------
Pinctrl that got accidentially dropped when reorganizing the
dts files and addition of the new Rockchip list to MAINTAINERS.

----------------------------------------------------------------
Heiko Stuebner (2):
      ARM: dts: rockchip: readd missing mmc0 pinctrl settings
      MAINTAINERS: add new Rockchip SoC list

 MAINTAINERS                            | 1 +
 arch/arm/boot/dts/rk3066a-bqcurie2.dts | 2 ++
 arch/arm/boot/dts/rk3188-radxarock.dts | 2 ++
 3 files changed, 5 insertions(+)
