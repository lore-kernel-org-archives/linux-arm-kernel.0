From: bhumirks@gmail.com (Bhumika Goyal)
Date: Mon, 16 Oct 2017 12:08:22 +0200
Subject: [PATCH 0/2] ARM: davinci: make function argument and structure const
Message-ID: <1508148504-2771-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the function argument of davinci_common_init const. 
After doing this change make the structures davinci_soc_info const.

Bhumika Goyal (2):
  ARM: davinci: make the function argument as const
  ARM: davinci: make davinci_soc_info structures const

 arch/arm/mach-davinci/common.c              | 2 +-
 arch/arm/mach-davinci/da830.c               | 2 +-
 arch/arm/mach-davinci/da850.c               | 2 +-
 arch/arm/mach-davinci/dm355.c               | 2 +-
 arch/arm/mach-davinci/dm365.c               | 2 +-
 arch/arm/mach-davinci/dm644x.c              | 2 +-
 arch/arm/mach-davinci/dm646x.c              | 2 +-
 arch/arm/mach-davinci/include/mach/common.h | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

-- 
1.9.1
