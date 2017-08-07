From: guodong.xu@linaro.org (Guodong Xu)
Date: Mon,  7 Aug 2017 16:13:18 +0800
Subject: [PATCH 0/7] arm64: dts: hi3660: add more device nodes
Message-ID: <20170807081325.11406-1-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds more device nodes for hi3660 and hikey960, including:
 - cpu idle states
 - L2 cache
 - PMU
 - OP-TEE
 - reboot
 - pstore

Patch 7 fixes an issue in mmc nodes, by adding 'reset'

HiKey960 is one of 96boards. For details information about it, please
refer to [1].

[1] https://github.com/96boards/documentation/tree/master/ConsumerEdition/HiKey960

Guodong Xu (3):
  arm64: dts: hikey960: Add support for syscon-reboot-mode
  arm64: dts: hikey960: Add pstore support
  arm64: dts: hi3660: Reset the mmc hosts

Leo Yan (2):
  arm64: dts: hi3660: enable idle states
  arm64: dts: hi3660: add L2 cache topology

Victor Chong (1):
  arm64: dts: hikey960: Add optee node

YiPing Xu (1):
  arm64: dts: hi3660: add pmu dt node for hi3660

 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts |  35 ++++++++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi         | 101 ++++++++++++++++++++++
 2 files changed, 136 insertions(+)

-- 
2.10.2
