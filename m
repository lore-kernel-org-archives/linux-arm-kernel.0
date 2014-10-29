From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Wed, 29 Oct 2014 16:25:55 +0800
Subject: [PATCH v4 00/10] hix5hd2 add some nodes
Message-ID: <1414571165-23736-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v4:
Rebase on 3.18-rc1
Update hisi_defconfig, adding some drivers for hix5hd2
Reuse syscon-reboot for reboot, drivers/power/reset/syscon-reboot.c

Test hisi_defconfig on hix5hd2, d01 and k3v2

v3: 
Change node wdt for a watchdog timer as comment from Dinh

v2:
Add comments of mac-address, suggested by Mark

Zhangfei Gao (10):
  ARM: dts: hix5hd2: add gmac node
  ARM: dts: hix5hd2: add mmc node
  ARM: dts: hix5hd2: add usb node
  ARM: dts: hix5hd2: add sata node
  ARM: dts: hix5hd2: add gpio node
  ARM: dts: hix5hd2: add wdg node
  ARM: dts: hix5hd2: add ir node
  ARM: dts: hix5hd2: add i2c node
  ARM: dts: hix5hd2: add reboot node
  ARM: hisi_defconfig: add driver support for hix5hd2

 arch/arm/boot/dts/hisi-x5hd2-dkb.dts |   33 +++
 arch/arm/boot/dts/hisi-x5hd2.dtsi    |  390 +++++++++++++++++++++++++++++++++-
 arch/arm/configs/hisi_defconfig      |   19 ++
 3 files changed, 440 insertions(+), 2 deletions(-)

-- 
1.7.9.5
