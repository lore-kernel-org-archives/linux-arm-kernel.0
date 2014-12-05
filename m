From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  5 Dec 2014 15:44:53 +0100
Subject: [PATCH 0/5] ARM: mvebu: Add Armada 385 AP support
Message-ID: <1417790698-9792-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This set of patches add the support for the Armada 385 AP board.

It also adds a few clean ups here and there, a few missing pin
functions needed for the board, etc.

Maxime

Maxime Ripard (5):
  ARM: mvebu: Rename DEBUG_LL to indicate UART index
  ARM: mvebu: Add UART1 as DEBUG_LL possible target
  ARM: mvebu: a38x: Fix node names
  pinctrl: mvebu: a38x: Add UART1 muxing options
  ARM: mvebu: Add Armada 385 Access Point Development Board support

 arch/arm/Kconfig.debug                     |  35 +++--
 arch/arm/boot/dts/Makefile                 |   1 +
 arch/arm/boot/dts/armada-385-ap.dts        | 200 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/armada-385-db.dts        |   2 +-
 arch/arm/boot/dts/armada-385-rd.dts        |   2 +-
 arch/arm/boot/dts/armada-385.dtsi          |   2 +-
 arch/arm/boot/dts/armada-38x.dtsi          |   4 +-
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c |   6 +-
 8 files changed, 236 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-385-ap.dts

-- 
2.2.0
