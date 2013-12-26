From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 26 Dec 2013 15:22:26 +0100
Subject: [PATCH 0/2] ARM: mvebu: minor improvements
Message-ID: <1388067748-18414-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Andrew, Gregory, Sebastian,

Here are again the two patches I sent to you this morning, which I'm
resending because I forgot to Cc LAKML. Hopefully this time I do not
forget it.

The two patches do some minor cleanups/improvements in the mach-mvebu
header files.

Thanks!

Thomas

Thomas Petazzoni (2):
  ARM: mvebu: remove prototypes of non-existing functions from common.h
  ARM: mvebu: move Armada 370/XP specific definitions to armada-370-xp.h

 arch/arm/mach-mvebu/armada-370-xp.h | 2 ++
 arch/arm/mach-mvebu/common.h        | 8 +-------
 2 files changed, 3 insertions(+), 7 deletions(-)

-- 
1.8.3.2
