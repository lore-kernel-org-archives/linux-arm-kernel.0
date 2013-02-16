From: anilk4.v@gmail.com (Anil Kumar)
Date: Sat, 16 Feb 2013 17:08:26 +0530
Subject: [PATCH 0/2] arm/dts: OMAP3: Add gpmc DT node support
Message-ID: <1361014708-1659-1-git-send-email-anilk4.v@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add gpmc DT node in dtsi file.
Add nand DT node and partitions information for devkit8000.

This series is based on top of branch ???omap-for-v3.9/gpmc??? git tree 
http://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
and patches.

Anil Kumar:-
ARM: dts: add minimal DT support for DevKit8000

Jon Hunter:- 
  ARM: OMAP2+: Fix-up gpmc merge error

Done basic testing:-
 - #cat /proc/mtd     (shows nand partitions) 
 - Nand partitions by command line.

Anil Kumar (2):
  ARM: dts: omap3: Add gpmc node
  ARM: dts: omap3-devkit8000: add nand dt node

 arch/arm/boot/dts/omap3-devkit8000.dts |   52 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3.dtsi           |   11 +++++++
 2 files changed, 63 insertions(+), 0 deletions(-)
