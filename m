From: leoy@marvell.com (Leo Yan)
Date: Mon,  1 Aug 2011 10:59:05 +0800
Subject: [PATCH V2 0/2] ARM: mmp: add audio sram support
Message-ID: <1312167547-26740-1-git-send-email-leoy@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On mmp platform, there have sram buffer dedicated
to audio island. It can be to dynamically allocated
for versatile pcm devices. So add the audio sram
allocator for managing it.

Leo Yan (2):
  ARM: mmp: register audio sram device
  ARM: mmp: add audio sram allocator

 arch/arm/Kconfig                            |    1 +
 arch/arm/mach-mmp/Makefile                  |    2 +-
 arch/arm/mach-mmp/audio_sram.c              |   99 +++++++++++++++++++++++++++
 arch/arm/mach-mmp/brownstone.c              |    1 +
 arch/arm/mach-mmp/include/mach/audio_sram.h |   24 +++++++
 arch/arm/mach-mmp/include/mach/mmp2.h       |    6 ++
 arch/arm/mach-mmp/mmp2.c                    |    1 +
 7 files changed, 133 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-mmp/audio_sram.c
 create mode 100644 arch/arm/mach-mmp/include/mach/audio_sram.h

-- 
1.7.4.1
