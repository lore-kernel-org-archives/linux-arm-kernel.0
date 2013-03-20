From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 20 Mar 2013 16:34:24 -0700
Subject: [PATCH 0/3] ARM: context tracking support prerequisites
Message-ID: <1363822467-6275-1-git-send-email-khilman@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is a set of prerequistes for getting the new context
tracking subsystem, and adaptive tickless support working on ARM.

Kevin Hilman (3):
  cputime_nsecs: use math64.h for nsec resolution conversion helpers
  init/Kconfig: virt CPU accounting: drop 64-bit requirment
  ARM: Kconfig: allow virt CPU accounting

 arch/arm/Kconfig                    |  1 +
 include/asm-generic/cputime_nsecs.h | 28 +++++++++++++++++++---------
 init/Kconfig                        |  2 +-
 3 files changed, 21 insertions(+), 10 deletions(-)

-- 
1.8.2
