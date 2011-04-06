From: marek.belisko@open-nandra.com (Marek Belisko)
Date: Wed,  6 Apr 2011 15:01:33 +0200
Subject: [PATCH v2 0/4] s3c2440: mini2440: Add missing code parts to be fully
	working with latest kernel.
Message-ID: <1302094897-18446-1-git-send-email-marek.belisko@open-nandra.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

changes from v1 to v2: Replace original patch [4] with generic leds-gpio driver.

Patch add new LCD panels with which was board produced. Also add touchscreen
support. Enabling LCD backlight during early booting stage also added.

Some code parts are collected or inspired from other code (authors are in CC).

Marek Belisko (4):
  s3c2440: mini2440: Add support for new LCD panels.
  s3c2440: mini2440: Add touchscreen support for mini2440.
  s3c2440: mini2440: Select touchscreen by default.
  s3c2440: mini2440: Use leds-gpio driver for board leds handling.

 arch/arm/mach-s3c2440/Kconfig         |    1 +
 arch/arm/mach-s3c2440/mach-mini2440.c |  176 ++++++++++++++++++++-------------
 2 files changed, 107 insertions(+), 70 deletions(-)
