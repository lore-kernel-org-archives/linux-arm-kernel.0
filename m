From: mhei@heimpold.de (Michael Heimpold)
Date: Wed, 26 Mar 2014 23:35:01 +0100
Subject: [PATCH 0/3] arm: mxs: dts: small fixes for I2SE's duckbills
Message-ID: <1395873319-28286-1-git-send-email-mhei@heimpold.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series fixes two issues with the DT file: first, it frees up
some GPIOs which are mis-used by MMC interface, and second, it
fixes the GPIO used to reset the ethernet phy.

While at it, use symbolic names for LED definitions.

Michael Heimpold (3):
  arm: mxs: dt: imx28-duckbill: fix mmc settings
  arm: mxs: dt: imx28-duckbill: fix phy reset gpio
  arm: mxs: dt: imx28-duckbill: use symbolic names from gpio.h

 arch/arm/boot/dts/imx28-duckbill.dts |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
1.7.10.4
