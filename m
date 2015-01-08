From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu,  8 Jan 2015 12:03:42 +0100
Subject: [PATCH v2 0/2] ARM: mediatek: Enable uart for mt6589
Message-ID: <1420715024-27738-1-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds uart ports for the mt6589 SoC from Mediatek.
It also enables the uart port for the mt6589 based Aquaris5 mobile phone.

This series is based on 3.19-rc1 and assumes that sysirq patch from Yingjoe Chen is added to the SoC [0].

Changes for v2:
- use uart0 reference
- add stdout-path
- enable uart3

[0] https://lkml.org/lkml/2014/11/25/132

Matthias Brugger (2):
  ARM: mediatek: dts: Add uart to mt6589
  ARM: mediatek: dts: Add uart to Aquaris5

 arch/arm/boot/dts/mt6589-aquaris5.dts | 12 ++++++++++-
 arch/arm/boot/dts/mt6589.dtsi         | 38 +++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)

-- 
1.9.1
