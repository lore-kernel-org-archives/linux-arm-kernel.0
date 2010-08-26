From: mark.brown314@gmail.com (Mark F. Brown)
Date: Thu, 26 Aug 2010 05:07:28 -0400
Subject: [PATCH 0/1] ARM: pxa168: fix corrected reset vector
Message-ID: <1282813649-8332-1-git-send-email-mark.brown314@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reset vector for pxa168 is 0xffff_0000 not 0x0
This fix allows reboot to work

Mark F. Brown (1):
  ARM: pxa168: fix corrected reset vector

 arch/arm/mach-mmp/include/mach/system.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
