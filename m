From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 11 Aug 2012 22:33:15 +0000
Subject: [PATCH V2 0/3] ARM: Kirkwood: update defconfig, add dt boards
In-Reply-To: <cover.1344651264.git.jason@lakedaemon.net>
Message-ID: <cover.1344720707.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a small series to update kirkwood_defconfig to include all of the new
DT boards.  And, finally, SERIAL_OF_PLATFORM is enabled. ;-)

Changes from V1:

  - dropped fix for arch/arm/mach-kirkwood/Makefile.boot since the same patch
    was already posted.
  - removed unneeded defconfig changes so it's purely adding DT boards and
    SERIAL_OF_PLATFORM

Jason Cooper (2):
  ARM: Kirkwood: update defconfig
  ARM: Kirkwood: add DT boards to defconfig

 arch/arm/configs/kirkwood_defconfig |   33 ++++++++++++++-------------------
 1 files changed, 14 insertions(+), 19 deletions(-)

-- 
1.7.8.6
