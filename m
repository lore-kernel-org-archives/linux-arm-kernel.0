From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri,  5 Apr 2013 12:00:35 +0200
Subject: [PATCH v5 0/3] CPUFreq for sh73a0 / kzm9g, using cpufreq-cpu0
Message-ID: <1365156038-12467-1-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v5: essentially identical to v4, one hunk has been moved from one patch
over to another one, patch #1 no longer depends on a different patch-
series, which will have to be updated.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Guennadi Liakhovetski (3):
  ARM: shmobile: sh73a0: add support for adjusting CPU frequency
  ARM: shmobile: kzm9g-reference: add AS3711 and CPUFreq DT bindings
  ARM: shmobile: sh73a0: add CPUFreq support

 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |   86 +++++++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig               |    2 +
 arch/arm/mach-shmobile/clock-sh73a0.c        |   95 +++++++++++++++++++++++++-
 arch/arm/mach-shmobile/setup-sh73a0.c        |    5 ++
 4 files changed, 186 insertions(+), 2 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
