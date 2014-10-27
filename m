From: linux@rempel-privat.de (Oleksij Rempel)
Date: Mon, 27 Oct 2014 10:23:10 +0100
Subject: [PATCH 0/2] initial suport for Alphascale ASM9260
Message-ID: <1414401792-7445-1-git-send-email-linux@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is reduced patchset to provide initial support for Alpascale ASM9260.


Oleksij Rempel (2):
  ARM: add mach-asm9260
  ARM: add lolevel debug support for asm9260

 arch/arm/Kconfig                 |  2 ++
 arch/arm/Kconfig.debug           | 33 ++++++++++++++++++++++++++++++---
 arch/arm/include/debug/asm9260.S | 31 +++++++++++++++++++++++++++++++
 arch/arm/mach-asm9260/Kconfig    |  6 ++++++
 4 files changed, 69 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/include/debug/asm9260.S
 create mode 100644 arch/arm/mach-asm9260/Kconfig

-- 
1.9.1
