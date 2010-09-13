From: mark.brown314@gmail.com (Mark F. Brown)
Date: Sun, 12 Sep 2010 23:51:33 -0400
Subject: [PATCH v2 0/3] ARM: pxa168: Added Teton BGA Board Support
Message-ID: <1284349896-14545-1-git-send-email-mark.brown314@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1) Support for Teton BGA Board
2) Keypad support for Teton BG
3) RTC support

Version 2:
1) Added information to MAINTAINERS
2) Added Authorship information
3) Added teton_bga.h in the board support patch
4) Added ALARM interrupt support for RTC

Patched on top of Eric Miao's tree commit 5df3afbca20235ff8b3d33bd0d26a0d47b989a30

Mark F. Brown (3):
  ARM: pxa168: added support for Teton BGA platform
  ARM: pxa168/teton bga: added keypad support
  ARM: pxa168/teton bga: add board support for i2c and rtc-ds1337

 MAINTAINERS                                |    5 ++
 arch/arm/mach-mmp/Kconfig                  |    7 ++
 arch/arm/mach-mmp/Makefile                 |    1 +
 arch/arm/mach-mmp/include/mach/teton_bga.h |   27 ++++++++
 arch/arm/mach-mmp/teton_bga.c              |   90 ++++++++++++++++++++++++++++
 5 files changed, 130 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mmp/include/mach/teton_bga.h
 create mode 100644 arch/arm/mach-mmp/teton_bga.c
