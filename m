From: avinashphilip@ti.com (Philip, Avinash)
Date: Sat, 29 Sep 2012 16:05:18 +0530
Subject: [PATCH 0/2] ARM: dts: AM33XX: Add ECAP and EHRPWM device tree data
Message-ID: <1348914920-30737-1-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for device tree data for ECAP & EHRPWM
& device tree data for am335x-evm with PWM as backlight.

This has been based on [1] merged with [2] & depends on [3]
1. linux-next/master
2. linux-omap-dt/for_3.7/dts_part2
3. http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg312091.html

PWM back light tested on AM335X evm for different backlight levels.

Philip, Avinash (2):
  ARM: dts: AM33XX: Add ECAP & EHRPWM device tree nodes
  ARM: dts: AM33XX: Add PWM backlight DT data to am335x-evm

 arch/arm/boot/dts/am335x-evm.dts |   21 ++++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi    |   48 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 0 deletions(-)
