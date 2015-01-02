From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri,  2 Jan 2015 19:48:03 +0100
Subject: [PATCH 0/2] ARM: mediatek: Enable uart for mt6589
Message-ID: <1420224485-11043-1-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds uart ports for the mt6589 SoC from Mediatek.
It also enables the uart port for the mt6589 based Aquaris5 mobile phone.

This series is based on 3.19-rc1 and assumes that sysirq patch from Yingjoe Chen is added to the SoC [0].

[0] https://lkml.org/lkml/2014/11/25/132

Matthias Brugger (2):
  ARM: mediatek: dts: Add uart to mt6589
  ARM: mediatek: dts: Add uart to Aquaris5

 arch/arm/boot/dts/mt6589-aquaris5.dts |  8 +++++++-
 arch/arm/boot/dts/mt6589.dtsi         | 38 +++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

-- 
1.9.1
