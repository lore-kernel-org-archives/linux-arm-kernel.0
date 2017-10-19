From: bhumirks@gmail.com (Bhumika Goyal)
Date: Thu, 19 Oct 2017 12:59:13 +0200
Subject: [PATCH 0/2] cpufreq: arm_big_little: make function arguments and
 structures const
Message-ID: <1508410755-13666-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make some function arguments as const. After this change make the 
cpufreq_arm_bL_ops structures const.

Bhumika Goyal (2):
  cpufreq: arm_big_little: make function argument and structure const
  cpufreq: arm_big_little: make cpufreq_arm_bL_ops structures const

 drivers/cpufreq/arm_big_little.c       | 6 +++---
 drivers/cpufreq/arm_big_little.h       | 4 ++--
 drivers/cpufreq/arm_big_little_dt.c    | 2 +-
 drivers/cpufreq/scpi-cpufreq.c         | 2 +-
 drivers/cpufreq/vexpress-spc-cpufreq.c | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

-- 
1.9.1
