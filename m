From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Wed,  6 Oct 2010 01:09:49 +0200
Subject: [PATCH 0/2] ARM: S3C64XX: SmartQ: add suspend support
Message-ID: <cover.1286319272.git.mcuelenaere@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add suspend support to the SmartQ (and other S3C64XX) boards.

Currently the LCD needs re-initializing when waking up, otherwise it'll just
display a WSOD.

This was tested on a SmartQ 7.

Maurus Cuelenaere (2):
  ARM: S3C64XX: Add suspend support
  ARM: S3C64XX: Add wakeup sources to SmartQ boards

 arch/arm/mach-s3c64xx/mach-smartq5.c |    1 +
 arch/arm/mach-s3c64xx/mach-smartq7.c |    1 +
 arch/arm/mach-s3c64xx/pm.c           |    3 +++
 3 files changed, 5 insertions(+), 0 deletions(-)

-- 
1.7.2.3
