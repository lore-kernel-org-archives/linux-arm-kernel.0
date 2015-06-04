From: arun@gumstix.com (Arun Bharadwaj)
Date: Thu,  4 Jun 2015 11:08:16 -0700
Subject: [PATCH 0/3] ARM: dts: Changes for Gumstix Pepper dts
Message-ID: <1433441299-18887-1-git-send-email-arun@gumstix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These 3 patches are included to fix the following issues
with pepper device tree source. The patches are based against
linux-omap/master.

Adam YH Lee (2):
  ARM: dts: Correct audio input route & set mic bias
  ARM: dts: configure regulators for Gumstix Pepper

Arun Bharadwaj (1):
  ARM: dts: Fix frequency scaling on Gumstix Pepper.

 arch/arm/boot/dts/am335x-pepper.dts | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

-- 
2.1.4
