From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 11 Sep 2013 11:30:01 +0200
Subject: [PATCH 0/4] ARM: sun7i: Enable the I2C support for the A20
Message-ID: <1378891805-28957-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This patchset enables the support for the I2C IP found in the Allwinner A20.
Since it's basically the same IP than the one found in the other Allwinner
SoCs, it's just a matter of enabling it in the device tree.

Thanks,
Maxime

Maxime Ripard (4):
  ARM: sun7i: Enable the I2C controllers
  ARM: sun7i: Add the pin muxing options for the I2C controllers
  ARM: sun7i: cubieboard2: Enable the I2C controllers
  ARM: sun7i: olinuxino-micro: Enable the I2C controllers

 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     | 12 +++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 18 +++++++
 arch/arm/boot/dts/sun7i-a20.dtsi                | 66 +++++++++++++++++++++++++
 3 files changed, 96 insertions(+)

-- 
1.8.4
