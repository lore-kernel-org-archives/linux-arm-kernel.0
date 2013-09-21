From: cinifr@gmail.com (Fan Rong)
Date: Sat, 21 Sep 2013 21:05:13 +0800
Subject: [PATCH 0/3]
Message-ID: <1379768716-11672-1-git-send-email-cinifr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Fan Rong (3):
  Add smp support for Allwinner A20(sunxi 7i).
  Add cpuconfig nodes in dts for smp configure.
  Add arch count timer node in dts for Allwinner A20(sunxi 7i).

 arch/arm/boot/dts/sun7i-a20.dtsi |  19 ++-
 arch/arm/mach-sunxi/Makefile     |   2 +
 arch/arm/mach-sunxi/headsmp.S    |  12 ++
 arch/arm/mach-sunxi/platform.h   | 347 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-sunxi/platsmp.c    | 100 +++++++++++
 arch/arm/mach-sunxi/sunxi.c      |  34 +++-
 6 files changed, 511 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-sunxi/headsmp.S
 create mode 100644 arch/arm/mach-sunxi/platform.h
 create mode 100644 arch/arm/mach-sunxi/platsmp.c

-- 
1.8.1.2
