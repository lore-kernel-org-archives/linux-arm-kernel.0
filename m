From: andy.yan@rock-chips.com (Andy Yan)
Date: Sat, 22 Oct 2016 20:51:46 +0800
Subject: [PATCH 0/2] Use macros to describe gpios on rockchip platform
Message-ID: <1477140706-6886-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


As patch 150696e2e3a4("Add GPIO pin index definition for rockchip pinctrl") has
been applied, now we can use these macros to describe the corresponding gpio
ranther than hard code numbers, this will make the dts easier to read and
write.

Some ideas from Krzysztof's patch on EXYNOS[0].

[0]https://lkml.org/lkml/2016/9/4/71



Andy Yan (2):
  ARM: dts: rockchip: use pin constants to describe gpios
  ARM64: dts: rockchip: use pin constants to describe gpios

 arch/arm/boot/dts/rk3036-evb.dts                   |  2 +-
 arch/arm/boot/dts/rk3036-kylin.dts                 | 10 ++++-----
 arch/arm/boot/dts/rk3066a-bqcurie2.dts             |  6 +++---
 arch/arm/boot/dts/rk3066a-marsboard.dts            |  2 +-
 arch/arm/boot/dts/rk3066a-mk808.dts                | 10 ++++-----
 arch/arm/boot/dts/rk3066a-rayeager.dts             | 12 +++++------
 arch/arm/boot/dts/rk3188-px3-evb.dts               |  4 ++--
 arch/arm/boot/dts/rk3188-radxarock.dts             | 16 +++++++--------
 arch/arm/boot/dts/rk3229-evb.dts                   |  2 +-
 arch/arm/boot/dts/rk3288-evb-act8846.dts           |  4 ++--
 arch/arm/boot/dts/rk3288-evb.dtsi                  | 14 ++++++-------
 arch/arm/boot/dts/rk3288-fennec.dts                |  4 ++--
 arch/arm/boot/dts/rk3288-firefly-beta.dts          |  2 +-
 arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi  |  2 +-
 arch/arm/boot/dts/rk3288-firefly-reload.dts        | 24 +++++++++++-----------
 arch/arm/boot/dts/rk3288-firefly.dts               |  2 +-
 arch/arm/boot/dts/rk3288-firefly.dtsi              | 16 +++++++--------
 arch/arm/boot/dts/rk3288-miqi.dts                  |  8 ++++----
 arch/arm/boot/dts/rk3288-popmetal.dts              |  2 +-
 arch/arm/boot/dts/rk3288-r89.dts                   | 12 +++++------
 arch/arm/boot/dts/rk3288-rock2-som.dtsi            |  4 ++--
 arch/arm/boot/dts/rk3288-rock2-square.dts          | 12 +++++------
 arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi  |  4 ++--
 arch/arm/boot/dts/rk3288-veyron-brain.dts          |  8 ++++----
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi    | 10 ++++-----
 arch/arm/boot/dts/rk3288-veyron-jaq.dts            | 14 ++++++-------
 arch/arm/boot/dts/rk3288-veyron-jerry.dts          | 10 ++++-----
 arch/arm/boot/dts/rk3288-veyron-mickey.dts         |  6 +++---
 arch/arm/boot/dts/rk3288-veyron-minnie.dts         | 16 +++++++--------
 arch/arm/boot/dts/rk3288-veyron-pinky.dts          |  4 ++--
 arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi         |  2 +-
 arch/arm/boot/dts/rk3288-veyron-speedy.dts         | 10 ++++-----
 arch/arm/boot/dts/rk3288-veyron.dtsi               |  8 ++++----
 arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi       | 10 ++++-----
 arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts    |  8 ++++----
 .../boot/dts/rockchip/rk3368-orion-r68-meta.dts    | 14 ++++++-------
 arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts    |  4 ++--
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts        | 16 +++++++--------
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts        |  6 +++---
 39 files changed, 160 insertions(+), 160 deletions(-)

-- 
2.7.4
