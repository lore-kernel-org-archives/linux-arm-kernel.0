From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 18 Mar 2015 17:41:15 +0100
Subject: [GIT PULL 1/2] ARM: rockchip: soc code changes for 4.1
Message-ID: <2684132.lK2CyBin0M@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

some soc code changes for 4.1 . I hope the tag explains it, so please pull


Thanks
Heiko

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.1-rockchip-soc1

for you to fetch changes up to a0307d186f5015ee3d77e209e5c06190cbf02478:

  ARM: rockchip: disable watchdog during suspend (2015-03-11 22:41:02 +0100)

----------------------------------------------------------------
Some suspend improvements reducing resume time and making sure the
watchdog does not reset after 12 hours and a change to constify and
staticize some smp parts.

----------------------------------------------------------------
Chris Zhong (2):
      ARM: rockchip: decrease the wait time for resume
      ARM: rockchip: disable watchdog during suspend

Krzysztof Kozlowski (1):
      ARM: rockchip: Constify struct regmap_config and staticize local function

 arch/arm/mach-rockchip/platsmp.c |  4 ++--
 arch/arm/mach-rockchip/pm.c      | 14 +++++++++++---
 arch/arm/mach-rockchip/pm.h      |  6 ++++++
 3 files changed, 19 insertions(+), 5 deletions(-)
