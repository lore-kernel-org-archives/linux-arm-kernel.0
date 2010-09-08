From: mark.brown314@gmail.com (Mark F. Brown)
Date: Tue,  7 Sep 2010 22:56:44 -0400
Subject: [PATCH 0/3] ARM: pxa168: Added Teton BGA Board Support
Message-ID: <1283914607-10570-1-git-send-email-mark.brown314@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1) Support for Teton BGA Board
2) Keypad support for Teton BGA
3) RTC support

Patched on top of Eric Miao's tree commit 5df3afbca20235ff8b3d33bd0d26a0d47b989a30

Mark F. Brown (3):
  ARM: pxa168: added support for Teton BGA platform
  ARM: pxa168/teton bga: added keypad support
  ARM: pxa168/teton bga: add board support for i2c and rtc-ds1337

 arch/arm/mach-mmp/Kconfig     |    7 ++++
 arch/arm/mach-mmp/Makefile    |    1 +
 arch/arm/mach-mmp/teton_bga.c |   81 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mmp/teton_bga.c
