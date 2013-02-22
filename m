From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 22 Feb 2013 18:17:50 +0100
Subject: [PATCH/RFC 0/4] CPUFreq for kzm9g
Message-ID: <1361553474-27022-1-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first of these patches is a bug-fix, whereas the latter three patches 
are experimental and might want to be discussed. This patch set is based 
on an earlier Simon's topic/all+next branch snapshot. Attempts to use 
todays checkout failed - I couldn't even boot. Obviously, I'm also using 
my AS3711 patches and a number of other (not directly related) patches, 
that I'll be posting separately.

Guennadi Liakhovetski (4):
  ARM: shmobile: sh73a0: fix Z and ZG clock hierarchy
  ARM: shmobile: sh73a0: add support for adjusting CPU frequency
  ARM: shmobile: sh73a0: run sh73a0_clock_init() only once
  ARM: shmobile: kzm9g-reference: add CPUFreq support

 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |   19 ++-
 arch/arm/mach-shmobile/Kconfig               |    2 +
 arch/arm/mach-shmobile/clock-sh73a0.c        |  224 +++++++++++++++++++++++++-
 3 files changed, 236 insertions(+), 9 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
