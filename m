From: linux@rempel-privat.de (Oleksij Rempel)
Date: Mon,  3 Nov 2014 15:14:10 +0100
Subject: [PATCH v3 0/2] initial suport for Alphascale ASM9260
In-Reply-To: <20141102203438.GW3698@titan.lakedaemon.net>
References: <20141102203438.GW3698@titan.lakedaemon.net>
Message-ID: <1415024052-12351-1-git-send-email-linux@rempel-privat.de>
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
