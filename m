From: vbendeb@google.com (Vadim Bendebury)
Date: Fri, 13 May 2011 12:58:45 -0700 (PDT)
Subject: [PATCH 0/1] ARM: thumb: Fix thumb mode compilation problems.
Message-ID: <20110513195845.2FFE540CD1@eskimo.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch won't necessarily apply as it has not been verified on
a real hardware, so this is more of an RFC.

Vadim Bendebury (1):
  ARM: thumb: Fix thumb mode compilation problems.

 arch/arm/kernel/fiq.c         |   34 ++++++++++++++++++++++++++--------
 arch/arm/mach-tegra/headsmp.S |    3 ++-
 2 files changed, 28 insertions(+), 9 deletions(-)

-- 
1.7.3.1
