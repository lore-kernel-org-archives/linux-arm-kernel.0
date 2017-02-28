From: jon.mason@broadcom.com (Jon Mason)
Date: Tue, 28 Feb 2017 15:31:24 -0500
Subject: [PATCH 0/2] ARM: dts: bcm5301x: Add TWD and I2C
Message-ID: <1488313886-17155-1-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These seemed to have been lost sometime last year.  See
https://lkml.org/lkml/2016/5/11/953

I am dropping the syscon reboot from the series, as I believe that was
the sticking point, and resending the TWD and i2c patches.

Jon Mason (2):
  ARM: dts: bcm5301x: Add TWD WD Support to DT
  ARM: dts: bcm5301x: Add I2C support to the DT

 arch/arm/boot/dts/bcm5301x.dtsi | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

-- 
2.7.4
