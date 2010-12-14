From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Tue, 14 Dec 2010 16:08:25 +0100
Subject: [PATCH 0/2] ARM: Gemini: add RTC support for Gemini SoC 
Message-ID: <1292339307-14336-1-git-send-email-ulli.kroll@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the driver for the rtc chip on the Gemini SoC

I divided this patch into two parts.
One for the core rtc-driver in /drivers/rtc
and one for the needed platform bindings in /arch/arm/mach-gemini

 MAINTAINERS                           |    1 +
 arch/arm/mach-gemini/board-nas4220b.c |    1 +
 arch/arm/mach-gemini/board-rut1xx.c   |    1 +
 arch/arm/mach-gemini/board-wbd111.c   |    1 +
 arch/arm/mach-gemini/board-wbd222.c   |    1 +
 arch/arm/mach-gemini/common.h         |    1 +
 arch/arm/mach-gemini/devices.c        |   26 ++++
 drivers/rtc/Kconfig                   |    9 ++
 drivers/rtc/Makefile                  |    1 +
 drivers/rtc/rtc-gemini.c              |  206 +++++++++++++++++++++++++++++++++
 10 files changed, 248 insertions(+), 0 deletions(-)
