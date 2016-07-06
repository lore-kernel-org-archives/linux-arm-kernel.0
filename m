From: ayaka@soulik.info (ayaka)
Date: Wed,  6 Jul 2016 23:25:21 +0800
Subject: [PATCH 0/3] ARM: dts: the dts support for rk3288 firefly reload
Message-ID: <1467818724-21500-1-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3288 firefly reload  is a Rockchip RK3288 based board be found by
core board and main board. The regulators are connected in a different
way to the previous version of firefly boards, it is necessary to
move some common code to uncommon place.

I only tested the ethernet and confirmed that works.

ayaka (3):
  ARM: dts: add label leds for rk3288-firefly.dtsi
  ARM: dts: move regulator settings from common to specifics
  ARM: dts: add rk3288-firefly-reload

 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/rk3288-firefly-beta.dts   |  30 ++++++++
 arch/arm/boot/dts/rk3288-firefly-reload.dts | 109 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3288-firefly.dts        |  30 ++++++++
 arch/arm/boot/dts/rk3288-firefly.dtsi       |  16 ++--
 5 files changed, 178 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3288-firefly-reload.dts

-- 
2.7.4
