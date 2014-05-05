From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Mon,  5 May 2014 17:38:36 +0200
Subject: [PATCH 0/4] Enable ST Keyscan driver
Message-ID: <1399304320-18197-1-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The goal of this series is to enable ST Keyscan support to ST SoCs.
The DT definition is added for STiH415 and STiH416 SoCs on
B2000 board.
Tested on B2000 sti board.

Gabriel Fernandez (4):
  ARM: STi: DT: add keyscan for stih415
  ARM: STi: DT: add keyscan for stih416
  ARM: STi: DT: add keyscan for stih41x-b2000
  ARM: multi_v7_defconfig: add ST Keyscan driver

 arch/arm/boot/dts/stih415-pinctrl.dtsi | 16 ++++++++++++++++
 arch/arm/boot/dts/stih415.dtsi         | 12 ++++++++++++
 arch/arm/boot/dts/stih416-pinctrl.dtsi | 16 ++++++++++++++++
 arch/arm/boot/dts/stih416.dtsi         | 12 ++++++++++++
 arch/arm/boot/dts/stih41x-b2000.dtsi   | 23 +++++++++++++++++++++++
 arch/arm/configs/multi_v7_defconfig    |  1 +
 6 files changed, 80 insertions(+)

-- 
1.9.1
