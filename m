From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed,  3 Apr 2013 18:13:53 +0200
Subject: [PATCH/RFC 0/3] ARM: shmobile: kzm9g-reference: enable TWD
Message-ID: <1365005636-17526-1-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch in this series is required for the result to work, but is 
modifying a generic driver, so, it should be considered separately, and if 
accepted, it can be applied separately too. Patches 2 and 3 are RFC, 
because I'm not sure, whether this is indeed the right way to enable TWD 
on kzm9g-reference.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Guennadi Liakhovetski (3):
  ARM: also support TWD clock, instantiated from platform data
  ARM: shmobile: initialise clock early on kzm9g-reference
  ARM: shmobile: kzm9g-reference: add a TWD DT node

 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts   |    7 +++++++
 arch/arm/kernel/smp_twd.c                      |    2 +-
 arch/arm/mach-shmobile/board-kzm9g-reference.c |    8 +++++++-
 arch/arm/mach-shmobile/setup-sh73a0.c          |   13 +++++++++----
 4 files changed, 24 insertions(+), 6 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
