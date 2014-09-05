From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 5 Sep 2014 18:01:36 +0200
Subject: [GIT PULL] at91: fixes for 3.17 #1
Message-ID: <1409932896-4533-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Little pull-request for fixing CCF conversion done during 3.17.
The use of at91sam9g20 proper compatibility string is useful when booting
without U-Boot (this is why we discover it now).

Thanks, best regards,

The following changes since commit 69e273c0b0a3c337a521d083374c918dc52c666f:

  Linux 3.17-rc3 (2014-08-31 18:23:04 -0700)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-fixes

for you to fetch changes up to ea4fc621adec8956944ecdb9a36c549cba8718c0:

  ARM: at91/dt: rm9200: fix usb clock definition (2014-09-05 17:36:12 +0200)

----------------------------------------------------------------
First AT91 fixes batch for 3.17:
- compatibility string precision
- clock registration and USB DT fix for at91rm9200

----------------------------------------------------------------
Alexandre Belloni (2):
      ARM: at91: rm9200: fix clock registration
      ARM: at91/dt: rm9200: fix usb clock definition

Ga?l PORTAY (1):
      ARM: at91/dt: sam9g20: set at91sam9g20 pllb driver

 arch/arm/boot/dts/at91rm9200.dtsi    |  2 +-
 arch/arm/boot/dts/at91sam9g20.dtsi   |  1 +
 arch/arm/mach-at91/board-dt-rm9200.c | 11 ++++++++++-
 3 files changed, 12 insertions(+), 2 deletions(-)

-- 
Nicolas Ferre
