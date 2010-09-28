From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 28 Sep 2010 12:07:27 -0700
Subject: [PATCH 0/2] OMAP2+: misc. defconfig cleanups for 2.6.37
Message-ID: <1285700849-10000-1-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A couple of small defconfig changes for 2.6.37 with the goal of working
towards a smaller default kernel image.

Kevin Hilman (2):
  OMAP2+: defconfig: disable CPUfreq
  OMAP2+: defconfig: modularize bluetooth, audio and WLAN

 arch/arm/configs/omap2plus_defconfig |   34 +++++++++++++++-------------------
 1 files changed, 15 insertions(+), 19 deletions(-)

-- 
1.7.2.1
