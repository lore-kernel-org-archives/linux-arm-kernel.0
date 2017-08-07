From: guodong.xu@linaro.org (Guodong Xu)
Date: Mon,  7 Aug 2017 22:31:55 +0800
Subject: [PATCH 0/5] arm64: defconfig: enable configs for HiKey960
Message-ID: <20170807143200.6764-1-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset enables config items in arm64/defconfig for HiKey960. All
of them correspond to real functions on HiKey960.

Including:
 - Kirin PCIe
 - PMIC support, hi6421v530
 - syscon reboot mode
 - serdev bus
 - OP-TEE

HiKey960 is one of 96boards. For details information about it, please
refer to [1].

[1] https://github.com/96boards/documentation/tree/master/ConsumerEdition/HiKey960

Guodong Xu (3):
  arm64: defconfig: enable support hi6421v530 PMIC
  arm64: defconfig: enable CONFIG_SYSCON_REBOOT_MODE
  arm64: defconfig: enable support for serial port connected device

Victor Chong (1):
  arm64: defconfig: enable OP-TEE

Xiaowei Song (1):
  arm64: defconfig: enable Kirin PCIe

 arch/arm64/configs/defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.10.2
