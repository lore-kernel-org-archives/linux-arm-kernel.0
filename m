From: linux@rempel-privat.de (Oleksij Rempel)
Date: Tue, 28 Oct 2014 20:01:04 +0100
Subject: [PATCH v3 0/2] initial suport for Alphascale ASM9260
Message-ID: <1414522866-12544-1-git-send-email-linux@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is reduced patchset to provide initial support for Alphascale ASM9260.
It was rebased against current arm-soc/for-next branch (commit a43109cc14)

Oleksij Rempel (2):
  ARM: add mach-asm9260
  ARM: add lolevel debug support for asm9260

 arch/arm/Kconfig                 |  2 ++
 arch/arm/Kconfig.debug           | 31 ++++++++++++++++++++++++++++---
 arch/arm/include/debug/asm9260.S | 31 +++++++++++++++++++++++++++++++
 arch/arm/mach-asm9260/Kconfig    |  6 ++++++
 4 files changed, 67 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/include/debug/asm9260.S
 create mode 100644 arch/arm/mach-asm9260/Kconfig

-- 
1.9.1
