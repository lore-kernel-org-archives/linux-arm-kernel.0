From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 17 May 2011 17:09:36 +0200
Subject: [RFC 0/2] add rtc device to mach-mcs
Message-ID: <1305644978-19155-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is intentionally just a RFC, so people can play with the STMP->MXS
conversion patches for the RTC-driver. When the conversion of the driver itself
is approved, I will resend these patches with proper updates and request for
inclusion. Still, if you have comments about these patches, too, let me know.

Thanks,

   Wolfram

Wolfram Sang (2):
  arm: mach-mxs: add device for rtc
  arm: mach-mxs: add rtc to all boards

 arch/arm/mach-mxs/Kconfig                         |    3 +
 arch/arm/mach-mxs/devices-mx23.h                  |    2 +
 arch/arm/mach-mxs/devices-mx28.h                  |    2 +
 arch/arm/mach-mxs/devices/Kconfig                 |    3 +
 arch/arm/mach-mxs/devices/Makefile                |    1 +
 arch/arm/mach-mxs/devices/platform-rtc-stmp3xxx.c |   59 +++++++++++++++++++++
 arch/arm/mach-mxs/mach-mx23evk.c                  |    2 +
 arch/arm/mach-mxs/mach-mx28evk.c                  |    2 +
 arch/arm/mach-mxs/mach-tx28.c                     |    2 +
 9 files changed, 76 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-rtc-stmp3xxx.c

-- 
1.7.2.5
