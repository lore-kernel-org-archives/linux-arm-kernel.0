From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 11 May 2018 20:51:33 +0530
Subject: [PATCH 0/3] ARM: davinci: some dm646x related fixes
Message-ID: <20180511152136.29515-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here are some DM646x related fixes for issues I found
while testing the platform.

Sekhar Nori (3):
  ARM: davinci: dm646x: fix timer interrupt generation
  ARM: davinci: board-dm646x-evm: pass correct I2C adapter id for VPIF
  ARM: davinci: board-dm646x-evm: set VPIF capture card name

 arch/arm/mach-davinci/board-dm646x-evm.c | 5 ++++-
 arch/arm/mach-davinci/dm646x.c           | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.16.2
