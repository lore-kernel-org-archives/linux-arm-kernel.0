From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Wed, 21 Mar 2012 19:03:10 +0100
Subject: [PATCH 0/4] atmel-mci device tree support 
Message-ID: <1332352994-20983-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch-set adds device tree support for atmel-mci.

Regards

Ludovic

 .../devicetree/bindings/mmc/atmel-hsmci.txt        |   55 +++++++++++++++
 arch/arm/boot/dts/at91sam9g25ek.dts                |   16 ++++
 arch/arm/boot/dts/at91sam9x5.dtsi                  |   14 ++++
 arch/arm/mach-at91/at91sam9x5.c                    |    2 +
 drivers/mmc/host/atmel-mci.c                       |   74 +++++++++++++++++++-
 5 files changed, 158 insertions(+), 3 deletions(-)
 
