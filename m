From: scott.branden@broadcom.com (Scott Branden)
Date: Tue, 15 Aug 2017 10:25:57 -0700
Subject: [PATCH 0/6] ARM: dts: cygnus dts updates
Message-ID: <1502817964-8221-1-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is a collection of patches for the Cygnus SoC dts files.

Jason Uy (1):
  ARM: dts: cygnus: Enable Performance Monitoring Unit

Jonathan Richardson (1):
  ARM: dts: cygnus: Add additional peripherals to dtsi

Raveendra Padasalagi (1):
  ARM: dts: cygnus: Add generic-ehci/ohci nodes

Ray Jui (1):
  ARM: dts: cygnus: Fix incorrect UART2 register base

Scott Branden (2):
  ARM: dts: cygnus: place v3d in proper address ordered location
  ARM: dts: cygnus: add serial0 alias for uart3 on bcm91130_entphn

 arch/arm/boot/dts/bcm-cygnus.dtsi      | 149 +++++++++++++++++++++++++++++----
 arch/arm/boot/dts/bcm911360_entphn.dts |   7 +-
 2 files changed, 140 insertions(+), 16 deletions(-)

-- 
2.5.0
