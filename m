From: tmaimon77@gmail.com (Tomer Maimon)
Date: Fri, 16 Mar 2018 01:10:10 +0200
Subject: [PATCH v1 0/2] arm: npcm: Modify NPCM7XX machine code
Message-ID: <1521155412-29229-1-git-send-email-tmaimon77@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addressed patches from:
Arnd Bergmann: https://www.spinics.net/lists/arm-kernel/msg639250.html
			   https://www.spinics.net/lists/arm-kernel/msg639249.html
			   
Modify the NPCM and NPCM7XX configuration and enable L2 cache in 
the DT_MACHINE_START.

Tomer Maimon (2):
  arm: npcm: modify configuration for the NPCM7xx BMC.
  arm: npcm: Enable L2 Cache in NPCM7xx

 arch/arm/mach-npcm/Kconfig   | 40 +++++++++++-----------------------------
 arch/arm/mach-npcm/Makefile  |  4 +++-
 arch/arm/mach-npcm/npcm7xx.c |  2 ++
 3 files changed, 16 insertions(+), 30 deletions(-)

-- 
2.14.1
