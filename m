From: michael@walle.cc (Michael Walle)
Date: Thu,  9 Jun 2011 23:38:07 +0200
Subject: [PATCH v2] ARM: kirkwood: Add support for Buffalo LS-XHL
Message-ID: <1307655488-12811-1-git-send-email-michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the second version of my board support patch for the Buffalo
Linkstation XHL.

Changes from v1:
 * fix gpio-fan speeds

Michael Walle (1):
  ARM: kirkwood: Add support for Buffalo LS-XHL

 arch/arm/configs/kirkwood_defconfig  |    1 +
 arch/arm/mach-kirkwood/Kconfig       |    6 +
 arch/arm/mach-kirkwood/Makefile      |    1 +
 arch/arm/mach-kirkwood/lsxhl-setup.c |  313 ++++++++++++++++++++++++++++++++++
 arch/arm/tools/mach-types            |    1 +
 5 files changed, 322 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-kirkwood/lsxhl-setup.c

-- 
1.7.2.3
