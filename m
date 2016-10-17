From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Oct 2016 13:48:57 +0200
Subject: [PATCH 0/6] ARM: sun5i: chip: Misc improvements
Message-ID: <cover.92d041a0a6fe40f1c8839cabb70247445eaffdfb.1476704881.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is a bunch of patches I gathered for the CHIP, that enables a few
things, like the WiFi regulators (and its associated power sequence), a few
optional buses, etc.

Let me know what you think,
Maxime

Antoine Tenart (1):
  ARM: sun5i: chip: add a node for the w1 gpio controller

Maxime Ripard (5):
  ARM: sun5i: chip: Enable Wi-Fi SDIO chip
  ARM: sun5i: Rename A10s pins
  ARM: sun5i: Add SPI2 pins
  ARM: sun5i: Add RGB 565 LCD pins
  ARM: sun5i: chip: Add optional buses

 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |  4 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi                |  4 +-
 arch/arm/boot/dts/sun5i-r8-chip.dts              | 69 +++++++++++++++++-
 arch/arm/boot/dts/sun5i.dtsi                     | 24 ++++++-
 4 files changed, 97 insertions(+), 4 deletions(-)

-- 
git-series 0.8.10
