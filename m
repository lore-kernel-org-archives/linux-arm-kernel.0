From: linux@rempel-privat.de (Oleksij Rempel)
Date: Mon, 24 Nov 2014 12:07:03 +0100
Subject: [PATCH v4 0/2] initial suport for Alphascale ASM9260
Message-ID: <1416827225-16330-1-git-send-email-linux@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is reduced patchset to provide initial support for Alphascale ASM9260

Oleksij Rempel (2):
  ARM: add mach-asm9260
  ARM: add lolevel debug support for asm9260

 arch/arm/Kconfig                 |  2 ++
 arch/arm/Kconfig.debug           | 28 ++++++++++++++++++++++++++--
 arch/arm/include/debug/asm9260.S | 29 +++++++++++++++++++++++++++++
 arch/arm/mach-asm9260/Kconfig    |  6 ++++++
 4 files changed, 63 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/include/debug/asm9260.S
 create mode 100644 arch/arm/mach-asm9260/Kconfig

-- 
1.9.1
