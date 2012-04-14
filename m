From: alex@digriz.org.uk (Alexander Clouter)
Date: Sat, 14 Apr 2012 19:00:51 +0100
Subject: [PATCH 0/3] ARM: orion5x: ts78xx misc cleanups
Message-ID: <1334426454-3206-1-git-send-email-alex@digriz.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

General cleanup of some of the ts78xx board codebase.

Alexander Clouter (3):
  ARM: orion5x: ts78xx whitespace cleanups
  ARM: orion5x: ts78xx fix NAND resource off by one
  ARM: orion5x: ts78xx debugging changes

 arch/arm/mach-orion5x/ts78xx-fpga.h  |    6 +++---
 arch/arm/mach-orion5x/ts78xx-setup.c |   38 ++++++++++++++++++----------------
 2 files changed, 23 insertions(+), 21 deletions(-)

-- 
1.7.10
