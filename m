From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 17 May 2017 16:37:33 +0800
Subject: [PATCH 00/12] arm64: dts: hi3660: add device nodes
Message-ID: <20170517083745.24479-1-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds various devices nodes for hi3660 and hikey960.

HiKey960 is one of 96boards. For details information about it, please
refer to [1].

[1] https://github.com/96boards/documentation/tree/master/ConsumerEdition/HiKey960

Chen Feng (2):
  arm64: dts: hi3660: Add uarts nodes
  arm64: dts: hi3660: Add pl031 rtc node

Chen Jun (1):
  arm64: dts: hi3660: add power key dts node

Guodong Xu (4):
  dt-bindings: arm: hisilicon: add bindings for HiKey960 board
  arm64: dts: hisilicon: update compatible string for hikey960
  arm64: dts: hikey960: add WL1837 Bluetooth device node
  arm64: dts: hikey960: add LED nodes

Wang Xiaoyin (3):
  arm64: dts: hikey960: pinctrl: add more pinmux and pinconfig
  arm64: dts: hi3660: add gpio dtsi file for Hisilicon Hi3660 SOC
  arm64: dts: hi3660: add spi device nodes

Zhangfei Gao (2):
  arm64: dts: hi3660: add resources for clock and reset
  arm64: dts: Add I2C nodes for Hi3660

 .../bindings/arm/hisilicon/hisilicon.txt           |   4 +
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts  | 122 +++-
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          | 616 +++++++++++++++-
 .../arm64/boot/dts/hisilicon/hikey960-pinctrl.dtsi | 779 +++++++++++++++++++--
 4 files changed, 1448 insertions(+), 73 deletions(-)

-- 
2.10.2
