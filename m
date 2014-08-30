From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Sat, 30 Aug 2014 12:15:36 +0800
Subject: [PATCH v3 0/6] hix5hd2 add some nodes
Message-ID: <1409372142-5960-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v3: 
Change node wdt for a watchdog timer as comment from Dinh

v2:
Add comments of mac-address, suggested by Mark

Zhangfei Gao (6):
  ARM: dts: hix5hd2: add gmac node
  ARM: dts: hix5hd2: add mmc node
  ARM: dts: hix5hd2: add usb node
  ARM: dts: hix5hd2: add sata node
  ARM: dts: hix5hd2: add gpio node
  ARM: dts: hix5hd2: add wdg node

 arch/arm/boot/dts/hisi-x5hd2-dkb.dts |   33 ++++
 arch/arm/boot/dts/hisi-x5hd2.dtsi    |  310 ++++++++++++++++++++++++++++++++++
 2 files changed, 343 insertions(+)

-- 
1.7.9.5
