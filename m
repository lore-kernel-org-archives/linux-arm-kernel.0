From: marek.belisko@open-nandra.com (Marek Belisko)
Date: Tue, 29 Mar 2011 08:32:39 +0200
Subject: [PATCH 0/4] s3c2440: mini2440: Add missing code parts to be fully
	working with latest kernel.
Message-ID: <1301380363-3282-1-git-send-email-marek.belisko@open-nandra.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch add new LCD panels with which was board produced. Also add touchscreen
support. Enabling LCD backlight during early booting stage also added.

Some code parts are collected or inspired from other code (authors are in CC).

Marek Belisko (4):
  s3c2440: mini2440: Add support for new LCD panels.
  s3c2440: mini2440: Add touchscreen support for mini2440.
  s3c2440: mini2440: Select touchscreen by default.
  s3c2440: mini2440: Enable the backlight LED earlier at boot time.

 arch/arm/mach-s3c2410/include/mach/leds-gpio.h |    1 +
 arch/arm/mach-s3c2440/Kconfig                  |    1 +
 arch/arm/mach-s3c2440/mach-mini2440.c          |   55 +++++++++++++++++++++++-
 drivers/leds/leds-s3c24xx.c                    |    6 ++-
 4 files changed, 60 insertions(+), 3 deletions(-)
