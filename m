From: tim.kryger@linaro.org (Tim Kryger)
Date: Fri, 6 Dec 2013 15:45:26 -0800
Subject: [PATCH 0/2] Enable I2C on bcm28155-ap
Message-ID: <1386373528-13045-1-git-send-email-tim.kryger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables all the I2C busses on the bcm28155-ap board.

These patches appeared in another series that was partially accepted.
  https://lkml.org/lkml/2013/11/14/517

It depends on:  https://lkml.org/lkml/2013/12/5/508

Tim Kryger (2):
  ARM: dts: bcm281xx: Add i2c busses
  ARM: dts: bcm28155-ap: Enable all the i2c busses

 arch/arm/boot/dts/bcm11351.dtsi   | 40 +++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm28155-ap.dts | 20 ++++++++++++++++++++
 2 files changed, 60 insertions(+)

-- 
1.8.0.1
