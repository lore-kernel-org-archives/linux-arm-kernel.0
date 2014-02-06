From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 17:36:11 +0900
Subject: [PATCH v8 0/4] Add ethernet support for r7s72100
Message-ID: <1391675773-5430-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Horman <horms@verge.net.au>

Hi,

this series integrates ethernet support to sh-pfc for the r7s72100 SoC
and Genmai board.

This series is based on renesas-devel-v3.14-rc1-20140204
but patches from topic/r7s72100-v3.14-rc1-20140206 are required
in order to boot the Genmai board.


There are no changes to these patches since v7,
however driver patches included in that series have
been dropped as they are present in v3.14-rc1.

Simon Horman (2):
  ARM: shmobile: r7s72100: Add clock for r7s72100-ether
  ARM: shmobile: genmai: Enable r7s72100-ether

 arch/arm/mach-shmobile/board-genmai.c   | 21 +++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r7s72100.c |  4 ++++
 2 files changed, 25 insertions(+)

-- 
1.8.5.2
