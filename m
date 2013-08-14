From: ruslan.bilovol@ti.com (Ruslan Bilovol)
Date: Wed, 14 Aug 2013 11:35:46 +0300
Subject: [PATCH v2 0/2] omap4/twl6030: typical connection to omap4 as a
 separate dtsi file
Message-ID: <1376469348-10797-1-git-send-email-ruslan.bilovol@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

There is no functional changes between v1 and v2 - just
added the patch for omap4-var-som - Uri Yosef confirmed
this board have the same connection of OMAP4<->TWL6030 as
SDP4430 board

Ruslan Bilovol (2):
  arm: dts: twl6030: typical connection to omap4 as a separate dtsi
    file
  arm: dts: omap4: configure connection to PMIC on Variscite's SOM

 arch/arm/boot/dts/omap4-panda-common.dtsi |   21 +---------------
 arch/arm/boot/dts/omap4-sdp.dts           |   21 +---------------
 arch/arm/boot/dts/omap4-var-som.dts       |    1 +
 arch/arm/boot/dts/twl6030_omap4.dtsi      |   38 +++++++++++++++++++++++++++++
 4 files changed, 41 insertions(+), 40 deletions(-)
 create mode 100644 arch/arm/boot/dts/twl6030_omap4.dtsi

-- 
1.7.9.5
