From: j-keerthy@ti.com (Keerthy)
Date: Mon, 4 Apr 2016 23:59:01 +0530
Subject: [PATCH 0/2] ARM: keystone: Enable CPU hotplug 
Message-ID: <1459794543-4822-1-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Series enables CPU hotplug for K2HK. CPU Hotplug tested on
K2HK-EVM.

It is on top of 4.6-rc2.

Keerthy (2):
  keystone: dts: add psci command definition
  ARM: configs: keystone: Add CPU Hotplug related options

 arch/arm/boot/dts/keystone.dtsi     | 8 ++++++++
 arch/arm/configs/keystone_defconfig | 2 ++
 2 files changed, 10 insertions(+)

-- 
1.9.1
