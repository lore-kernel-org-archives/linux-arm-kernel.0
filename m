From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon,  9 Jul 2018 10:50:56 +0100
Subject: [PATCH 0/2] Support ARMv8R
Message-ID: <1531129858-8341-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv8R brings set of new features. Some of them, like PMSAv8, have
already been merged, so these patches add missing features for bare
minimimum support of ARMv8R.

Thanks!

Vladimir Murzin (2):
  ARM: NOMMU: Extend check for VBAR support
  ARM: NOMMU: Allow enter in Hyp mode

 arch/arm/kernel/head-nommu.S | 12 ++++++++++--
 arch/arm/mm/Kconfig          |  1 -
 arch/arm/mm/nommu.c          |  3 ++-
 3 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.0.0
