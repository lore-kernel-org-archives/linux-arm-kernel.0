From: avinashphilip@ti.com (Philip Avinash)
Date: Thu, 14 Mar 2013 16:07:30 +0530
Subject: [PATCH 0/3] Platform support for EHRPWM & ECAP devices in Davinci.
Message-ID: <1363257453-24747-1-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add platform support for EHRPWM and ECAP by providing clock nodes and
device tree nodes.
This series depends on [1] and [2] and is available for testing at [3]

[1] http://gitorious.org/linux-davinci/linux-davinci/trees/davinci-for-v3.9/dt-2
[2] https://gitorious.org/linux-pwm/linux-pwm/trees/for-next
[3] https://github.com/avinashphilip/am335x_linux/tree/davinci-for-v3.9_soc_pwm

Philip Avinash (3):
  arm: davinci: clock node support for ECAP & EHRPWM
  ARM: davinci: da850: Enable EHRPWM TBCLK from CFG_CHIP1
  ARM: davinci: da850: add EHRPWM & ECAP DT node

 arch/arm/boot/dts/da850.dtsi               |   30 ++++++++++++++++++++++++++++
 arch/arm/mach-davinci/da850.c              |   24 ++++++++++++++++++++++
 arch/arm/mach-davinci/da8xx-dt.c           |   20 +++++++++++++++++++
 arch/arm/mach-davinci/include/mach/da8xx.h |    1 +
 4 files changed, 75 insertions(+)

-- 
1.7.9.5
