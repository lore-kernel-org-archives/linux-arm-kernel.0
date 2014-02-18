From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 18 Feb 2014 14:46:26 +0800
Subject: [PATCH 0/5] ARM: prima2: a couple of minor fixes
Message-ID: <1392705991-29967-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

this patchset includes a couple of minor fixes about checkpatch issues, typo
and staticizing function.

Barry Song (5):
  ARM: prima2: l2x0: fix checkpatch issues
  ARM: prima2: platsmp: fix checkpatch issues
  ARM: prima2: common: fix checkpatch issues
  ARM: prima2: rtciobrg: fix the typo about license
  ARM: prima2: staticize sirfsoc_init_late function

 arch/arm/mach-prima2/common.c   |    8 ++++----
 arch/arm/mach-prima2/l2x0.c     |    9 ++++-----
 arch/arm/mach-prima2/platsmp.c  |    6 +++---
 arch/arm/mach-prima2/rtciobrg.c |    2 +-
 4 files changed, 12 insertions(+), 13 deletions(-)

-- 
1.7.5.4
