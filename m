From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 17 Jan 2016 00:24:54 +0800
Subject: [PATCH 0/3] ARM: dts: sun8i: Add timer/watchdog for A83T and
 Cubietruck Plus
Message-ID: <1452961497-10804-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

This small series adds the timer/watchdog block for A83T, and also a new
board, the A83T/H8 based Cubietruck Plus from Cubietech.

Patch 1 from Vishnu adds the timer device node. This was picked from his
github branch sunxi-a83-wip.

Patch 2 adds the watchdog device node. We get watchdog and reboot support
on the A83T.

Patch 3 adds a basic DTS file for the Cubieteuck Plus.

Chen-Yu Tsai (2):
  ARM: dts: sun8i: Add watchdog device node for A83T
  ARM: dts: sun8i: Add device tree for Cubietruck Plus

Vishnu Patekar (1):
  ARM: dts: sun8i: Enable timer node for A83T

 arch/arm/boot/dts/Makefile                       |  1 +
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts | 65 ++++++++++++++++++++++++
 arch/arm/boot/dts/sun8i-a83t.dtsi                | 15 ++++++
 3 files changed, 81 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts

-- 
2.7.0.rc3
