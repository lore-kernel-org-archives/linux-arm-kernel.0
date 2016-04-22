From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri, 22 Apr 2016 12:43:33 +0100
Subject: [PATCH 0/3] ARM: nommu: R-class fixes
Message-ID: <1461325416-29570-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Small set of fixes discovered with R-class cores.

Jean-Philippe Brucker (2):
  ARM: nommu: fix PMSAv7 setup
  ARM: nommu: change memory reserve for the vectors

Vladimir Murzin (1):
  ARM: domain: move {set,get}_domain under config guard

 arch/arm/include/asm/domain.h |    5 ++++-
 arch/arm/kernel/head-nommu.S  |    2 +-
 arch/arm/mm/nommu.c           |   15 ++++++++-------
 3 files changed, 13 insertions(+), 9 deletions(-)

-- 
1.7.9.5
